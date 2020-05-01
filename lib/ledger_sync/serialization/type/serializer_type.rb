# frozen_string_literal: true

require_relative 'value_type'

module LedgerSync
  class Serialization
    module Type
      class SerializerType < ValueType
        attr_reader :serializer

        def initialize(args = {})
          @serializer = args.fetch(:serializer)
        end

        def convert(args = {})
          value = args.fetch(:value)

          serializer.new.serialize(resource: value)
        end
      end
    end
  end
end
