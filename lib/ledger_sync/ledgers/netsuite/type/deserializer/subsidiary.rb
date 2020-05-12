# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Type
        module Deserializer
          class Subsidiary < LedgerSync::Type::Value
            private

            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              LedgerSync::Subsidiary.new(
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
end
