# frozen_string_literal: true

# Gem.find_files('ledger_sync/ledgers/quickbooks_online/serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deserializer < LedgerSync::Deserializer
        def deserialize(args = {})
          hash                  = args.fetch(:hash)
          merge_for_full_update = args.fetch(:merge_for_full_update, false)
          resource              = args.fetch(:resource)

          deserialized_resource = super(hash: hash, resource: resource)

          # Ref: https://github.com/LedgerSync/ledger_sync/issues/86
          if deserialized_resource.is_a?(LedgerSync::Ledgers::QuickBooksOnline::Account) &&
             deserialized_resource.account_type &&
             deserialized_resource.classification.blank?
            deserialized_resource.classification = deserialized_resource.class::TYPES_TO_CLASSIFICATION_MAPPING.fetch(
              deserialized_resource.account_type,
              nil
            )
          end

          return deserialized_resource unless merge_for_full_update

          merge_resources_for_full_update(
            hash: hash,
            ledger_resource: deserialized_resource,
            resource: resource
          )
        end

        def merge_resources_for_full_update(args = {})
          hash            = args.fetch(:hash)
          ledger_resource = args.fetch(:ledger_resource)
          resource        = args.fetch(:resource)
          merged_resource = resource.dup

          self.class.attributes.each do |_key, deserializer_attribute|
            next unless deserializer_attribute.references_many?

            resources_from_ledger = attribute_value_from_ledger(
              hash: hash,
              deserializer_attribute: deserializer_attribute,
              resource: merged_resource
            )

            resource_hash_from_ledger = Hash[resources_from_ledger.map { |e| [e.ledger_id, e] }]

            # Using original resource since it is overwritten by keyword arg
            merged_value = resource.send(deserializer_attribute.resource_attribute_dot_parts.first).map do |referenced|
              if referenced.ledger_id.nil? # Assume creating a new resource in ledger
                referenced
              elsif resource_hash_from_ledger.key?(referenced.ledger_id.to_s) # Merged ledger into local
                ledger_resource = resource_hash_from_ledger[referenced.ledger_id.to_s]
                ledger_resource_serializer = deserializer_attribute.type.deserializer.inferred_serializer_class.new
                deserializer_attribute.type.deserializer.new.deserialize(
                  hash: ledger_resource_serializer.serialize(resource: ledger_resource),
                  resource: referenced
                )
              end
              # Else assume delete from ledger
            end.compact

            merged_resource.assign_attribute(
              deserializer_attribute.resource_attribute_dot_parts.first,
              merged_value
            )
          end

          merged_resource
        end

        def self.amount(resource_attribute, args = {})
          attribute(
            resource_attribute,
            {
              type: Serialization::Type::AmountFloatToIntegerType.new
            }.merge(args)
          )
        end

        def self.date(resource_attribute, args = {})
          attribute(
            resource_attribute,
            {
              type: LedgerSync::Serialization::Type::ParseDateType.new(format: '%Y-%m-%d')
            }.merge(args)
          )
        end

        def self.id
          attribute(:ledger_id, hash_attribute: 'Id')
        end
      end
    end
  end
end
