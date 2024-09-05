# frozen_string_literal: true

module LedgerSync
  module Serialization
    module Type
      class DeserializerType < LedgerSync::Type::Value
        attr_reader :deserializer

        def initialize(args = {})
          @deserializer = args.fetch(:deserializer)

          super()
        end

        def cast_value(args = {})
          deserializer_attribute = args.fetch(:deserializer_attribute)
          resource               = args.fetch(:resource)
          value                  = args.fetch(:value)
          default                = args.fetch(:default, nil)

          return default if value.nil?

          first_dot = deserializer_attribute.resource_attribute_dot_parts.first.to_sym
          nested_resource = resource.send(first_dot)
          nested_resource ||= resource.class.resource_attributes[first_dot].type.resource_class.new


          deserializer.new.deserialize(hash: value, resource: nested_resource)
        end
      end
    end
  end
end
