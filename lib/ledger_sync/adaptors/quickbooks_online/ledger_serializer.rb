# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'

Gem.find_files('ledger_sync/adaptors/quickbooks_online/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class LedgerSerializer < Adaptors::LedgerSerializer
        def deserialize(hash:, merge_for_full_update: false)
          deserialized_resource = super(hash: hash)

          # Ref: https://github.com/LedgerSync/ledger_sync/issues/86
          deserialized_resource.classification ||= LedgerSerializerType::AccountType::TYPE_TO_CLASSIFICATION_MAPPING.fetch(deserialized_resource.account_type, nil) if deserialized_resource.is_a?(LedgerSync::Account) && deserialized_resource.account_type

          return deserialized_resource unless merge_for_full_update

          merge_resources_for_full_update(
            hash: hash,
            ledger_resource: deserialized_resource
          )
        end

        def merge_resources_for_full_update(hash:, ledger_resource:)
          merged_resource = resource.dup

          self.class.attributes.each do |ledger_serializer_attribute|
            next unless ledger_serializer_attribute.references_many?

            resources_from_ledger = attribute_value_from_ledger(
              hash: hash,
              ledger_serializer_attribute: ledger_serializer_attribute,
              resource: merged_resource
            )

            resource_hash_from_ledger = Hash[resources_from_ledger.map { |e| [e.ledger_id, e] }]

            # Using original resource since it is overwritten by keyword arg
            merged_value = resource.send(ledger_serializer_attribute.resource_attribute_dot_parts.first).map do |referenced|
              if referenced.ledger_id.nil? # Assume creating a new resource in ledger
                referenced
              elsif resource_hash_from_ledger.key?(referenced.ledger_id.to_s) # Merged ledger into local
                ledger_resource = resource_hash_from_ledger[referenced.ledger_id.to_s]
                ledger_resource_serializer = ledger_serializer_attribute.serializer.new(resource: ledger_resource)
                ledger_serializer_attribute.serializer.new(resource: referenced).deserialize(hash: ledger_resource_serializer.to_ledger_hash)
              end
              # Else assume delete from ledger
            end.compact

            merged_resource.assign_attribute(
              ledger_serializer_attribute.resource_attribute_dot_parts.first,
              merged_value
            )
          end

          merged_resource
        end

        def to_ledger_hash(deep_merge_unmapped_values: {}, only_changes: false)
          ret = super(only_changes: only_changes)
          return ret unless deep_merge_unmapped_values.any?

          deep_merge_if_not_mapped(
            current_hash: ret,
            hash_to_search: deep_merge_unmapped_values
          )
        end

        class << self
          attr_reader :quickbooks_online_resource_types_hash
        end

        def self.id(**keywords)
          super({ ledger_attribute: 'Id', resource_attribute: :ledger_id }.merge(keywords))
        end

        def self.ledger_serializer_for(resource_class:)
          QuickBooksOnline.const_get("#{resource_class.name.split('LedgerSync::')[1..-1].join('LedgerSync::')}::LedgerSerializer")
        end

        def self.quickbooks_online_resource_type
          @quickbooks_online_resource_type ||= begin
            qbo_type = Adaptor.ledger_resource_type_for(
              resource_class: inferred_resource_class
            )
            type_hash = QuickBooksOnline::LedgerSerializer
                        .quickbooks_online_resource_types_hash
                        .try(:fetch, qbo_type, nil)
            raise "Cannot define type in #{name}.  Type already exists: #{qbo_type}.  Defined previously by #{quickbooks_online_resource_types_hash[qbo_type][:serializer_class].name}" if type_hash.present? && (type_hash[:serializer_class] != serializer_class || type_hash[:resource_class] != inferred_resource_class)

            QuickBooksOnline::LedgerSerializer.class_eval do
              @quickbooks_online_resource_types_hash ||= {}
            end

            QuickBooksOnline::LedgerSerializer.quickbooks_online_resource_types_hash[qbo_type] = {
              resource_class: inferred_resource_class,
              serializer_class: self
            }

            qbo_type
          end
        end

        private

        def deep_merge_if_not_mapped(current_hash:, hash_to_search:)
          hash_to_search.each do |key, value|
            current_hash[key] = if current_hash.key?(key)
                                  if value.is_a?(Hash)
                                    deep_merge_if_not_mapped(
                                      current_hash: current_hash[key],
                                      hash_to_search: value
                                    )
                                  else
                                    current_hash[key]
                                  end
                                else
                                  value
                                end
          end

          current_hash
        end
      end
    end
  end
end

# Load other serializers to populate `QuickBooksOnline::LedgerSerializer.quickbooks_online_resource_types_hash`
Gem.find_files('ledger_sync/adaptors/quickbooks_online/**/ledger_serializer.rb').each { |path| require path }
