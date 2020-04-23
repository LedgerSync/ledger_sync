# frozen_string_literal: true

module LedgerSync
  class Serializer
    module Type
      class ValueType
        def convert(args = {})
          value = args.fetch(:value)

          value
        end
      end
    end
  end
end
