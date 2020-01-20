# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class TransactionReferenceType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return if value.nil?

            raise "Unknown value type.  Array expected.  Given: #{value.class.name}" unless value.is_a?(Array)
            return if value.empty?

            value.map do |item|
              resource_class = Adaptor.resource_from_ledger_type(type: item['TxnType'])

              raise "Unknown QuickBooks Online resource type: #{item['TxnType']}" if resource_class.blank?

              resource_class.new(
                ledger_id: item['TxnId']
              )
            end
          end

          def convert_from_local(value:)
            return if value.nil?
            raise "List expected.  Given: #{value.class.name}" unless value.is_a?(Array)
            raise "Resources expected.  Given: #{value.map { |i| i.class.name }.join(', ')}" unless value.all?(LedgerSync::Resource)

            value.map do |resource|
              {
                'TxnId' => resource.ledger_id,
                'TxnType' => Adaptor.ledger_resource_type_for(
                  resource_class: resource.class
                ).classify
              }
            end
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
