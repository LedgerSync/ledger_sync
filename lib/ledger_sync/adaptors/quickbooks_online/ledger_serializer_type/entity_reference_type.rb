# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class EntityReferenceType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return if value.nil?

            raise "Unknown value type.  Hash expected.  Given: #{value.class.name}" unless value.is_a?(Hash)
            return if value.empty?

            value = LedgerSync::Util::HashHelpers.deep_stringify_keys(value)
            resource_class = begin
              quickbooks_online_type_hash = QuickBooksOnline::LedgerSerializer.quickbooks_online_resource_types_hash.fetch(value['type'].downcase, nil)
              if quickbooks_online_type_hash.present?
                quickbooks_online_type_hash.try(:fetch, :resource_class, nil)
              else
                LedgerSync.resources[value['type'].downcase.to_sym]
              end
            end

            raise "Unknown QuickBooks Online resource type: #{value['type']}" if resource_class.blank?

            ret = resource_class.new(
              ledger_id: value['value']
            )

            ret.display_name = value['name'] if ret.respond_to?(:display_name)
            ret
          end

          def convert_from_local(value:)
            return if value.nil?
            raise "Resource expected.  Given: #{value.class.name}" unless value.is_a?(LedgerSync::Resource)

            ret = {
              'value' => value.ledger_id
            }
            ret['name'] = value.display_name if value.respond_to?(:display_name)
            ret['type'] = string_helpers.camelcase(
              QuickBooksOnline::LedgerSerializer.ledger_serializer_for(
                resource_class: value.class
              ).quickbooks_online_resource_type
            )
            ret
          end

          private

          def string_helpers
            @string_helpers ||= LedgerSync::Util::StringHelpers
          end
        end
      end
    end
  end
end
