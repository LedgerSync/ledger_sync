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
            resource_class = Adaptor.resource_from_ledger_type(type: value['type'])
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
            ret['type'] = Adaptor.ledger_resource_type_for(
              resource_class: value.class
            ).classify
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
