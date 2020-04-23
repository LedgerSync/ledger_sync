# frozen_string_literal: true

require_relative 'serializer_type'

module LedgerSync
  class Serialization
    module Type
      class ReferencesManyType < SerializerType
        def convert(args = {})
          value = args.fetch(:value)

          value.map do |one_value|
            super(value: one_value)
          end
        end
      end
    end
  end
end
