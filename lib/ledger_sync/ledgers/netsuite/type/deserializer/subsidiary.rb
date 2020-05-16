# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        module Deserializer
          class Subsidiary < LedgerSync::Type::Value
            def initialize(args = {})
              @subsidiary_class = args.fetch(:subsidiary_class)
            end

            private

            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              @subsidiary_class.new(
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
