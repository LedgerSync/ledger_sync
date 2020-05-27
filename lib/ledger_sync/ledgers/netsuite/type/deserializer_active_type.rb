# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerActiveType < LedgerSync::Type::Value
          def cast_value(args = {})
            value = args.fetch(:value)

            return if value.nil?

            case value
            when 'F'
              true
            when 'T'
              false
            else
              raise 'Unknown value'
            end
          end
        end

        def valid_classes
          [
            String
          ]
        end
      end
    end
  end
end
