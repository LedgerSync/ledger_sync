# frozen_string_literal: true

module LedgerSync
  class Serialization
    module Type
      class CamelToSnakeStringType < LedgerSync::Type::Value
        def cast_value(args = {})
          value = args.fetch(:value)

          return if value.nil?
          value.snakecase
        end
      end
    end
  end
end
