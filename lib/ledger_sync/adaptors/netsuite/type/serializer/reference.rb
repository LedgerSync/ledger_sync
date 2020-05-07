# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Type
        module Serializer
          class Reference < LedgerSync::Type::Value
            private

            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              {
                'id' => value.ledger_id
              }
            end

            def valid_classes
              [
                LedgerSync::Resource
              ]
            end
          end
        end
      end
    end
  end
end
