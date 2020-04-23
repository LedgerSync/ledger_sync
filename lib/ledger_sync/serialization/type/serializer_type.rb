# frozen_string_literal: true

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
