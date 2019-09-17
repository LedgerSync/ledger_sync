# frozen_string_literal: true

require_relative '../resource_attribute_set'

# Mixin for attribute functionality
module LedgerSync
  class ResourceAttribute
    module Mixin
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def _define_attribute_methods(name)
          class_eval do
            define_method name do
              attributes[name].value
            end

            define_method "#{name}=" do |val|
              attribute = attributes[name]

              unless attribute.valid_with?(value: val)
                raise ResourceError::AttributeTypeError.new(
                  attribute: attribute,
                  resource: self,
                  value: val
                )
              end

              attribute.value = val
            end

            serialize attributes: [name]
          end
        end

        def attribute(name, type:)
          resource_attribute = ResourceAttribute.new(name: name, type: type)

          _define_attribute_methods(name)

          attributes.add(resource_attribute)

          resource_attribute
        end

        def attributes
          @attributes ||= ResourceAttributeSet.new(resource: self)
        end
      end

      def initialize(*)
        # Initialize empty values
        attributes.keys.each { |e| instance_variable_set("@#{e}", nil) }

        super()
      end

      # Store attribute instance values separately
      def attributes
        @attributes ||= Marshal.load(Marshal.dump(self.class.attributes))
      end

      def serialize_attributes
        Hash[attributes.map { |k, v| [k, v.value] }]
      end
    end
  end
end