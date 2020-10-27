# frozen_string_literal: true

module LedgerSync
  module Serialization
    module Type
      class SerializerType < LedgerSync::Type::Value
        attr_reader :serializer

        def initialize(args = {})
          @serializer = args.fetch(:serializer)

          super()
        end

        def cast_value(args = {})
          value = args.fetch(:value)

          return if value.nil?

          serializer.new.serialize(resource: value)
        end
      end
    end
  end
end
