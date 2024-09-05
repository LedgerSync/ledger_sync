# frozen_string_literal: true

require_relative 'deserializer_type'

module LedgerSync
  module Serialization
    module Type
      class DeserializerReferencesManyType < DeserializerType
        def cast_value(args = {})
          deserializer_attribute = args.fetch(:deserializer_attribute)
          value                  = args.fetch(:value)
          resource               = args.fetch(:resource)
          default                = args.fetch(:default, nil)

          return default if value.nil?

          first_dot = deserializer_attribute.resource_attribute_dot_parts.first.to_sym
          nested_resource = resource.class.resource_attributes[first_dot].type.resource_class.new

          value.map do |one_value|
            deserializer.new.deserialize(hash: one_value, resource: nested_resource)
          end
        end
      end
    end
  end
end
