# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerLedgerClassType < LedgerSync::Type::Value
          def initialize(args = {})
            @ledger_class = args.fetch(:ledger_class)
          end

          private

          def cast_value(args = {})
            value = args.fetch(:value)

            return if value.nil?

            @ledger_class.new(
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
