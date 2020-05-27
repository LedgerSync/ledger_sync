# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerCurrencyType < LedgerSync::Type::Value
          def initialize(args = {})
            @currency_class = args.fetch(:currency_class)
          end

          private

          def cast_value(args = {})
            value = args.fetch(:value)

            return if value.nil?

            @currency_class.new(
              ledger_id: value.fetch('id', nil)
            )
          end

          def valid_classes
            [
              Hash
            ]
          end
        end
      end
    end
  end
end
