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
              resource_class = begin
                quickbooks_online_type_hash = QuickBooksOnline::LedgerSerializer.quickbooks_online_resource_types_hash.fetch(item['TxnType'].downcase, nil)
                if quickbooks_online_type_hash.present?
                  quickbooks_online_type_hash.try(:fetch, :resource_class, nil)
                else
                  LedgerSync.resources[item['TxnType'].downcase.to_sym]
                end
              end

              raise "Unknown QuickBooks Online resource type: #{item['TxnType']}" if resource_class.blank?

              ret = resource_class.new(
                ledger_id: item['TxnId']
              )
            end
          end

          def convert_from_local(value:)
            return if value.nil?
            raise "List expected.  Given: #{value.class.name}" unless value.is_a?(Array)
            # raise "Resources expected.  Given: #{value.map{|i| i.class.name}.join(', ')}" unless value.map{|i| i.class}.all?(LedgerSync::Resource)

            value.map do |resource|
              {
                'TxnId' => resource.ledger_id,
                'TxnType' => string_helpers.camelcase(
                  QuickBooksOnline::LedgerSerializer.ledger_serializer_for(
                    resource_class: resource.class
                  ).quickbooks_online_resource_type
                )
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
