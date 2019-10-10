# frozen_string_literal: true

require_relative '../resource_attribute_set'
require_relative 'dirty_mixin'

# Mixin for attribute functionality
module LedgerSync
  class ResourceAttribute
    module Mixin
      def self.included(base)
        base.include(DirtyMixin)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def _define_attribute_methods(name)
          class_eval do
            define_attribute_methods name

            define_method name do
              resource_attributes[name].value
            end

            define_method "#{name}=" do |val|
              public_send("#{name}_will_change!") unless val == resource_attributes[name] # For Dirty

              attribute = resource_attributes[name]

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

          resource_attributes.add(resource_attribute)

          resource_attribute
        end

        def resource_attributes
          @resource_attributes ||= ResourceAttributeSet.new(resource: self)
        end
      end

      def initialize(**data)
        # Initialize empty values
        resource_attributes.keys.each { |e| instance_variable_set("@#{e}", nil) }

        assign_attributes(data)

        super()
      end

      def assign_attribute(name, value)
        raise "#{name} is not an attribute of #{self.class.name}" unless resource_attributes.key?(name)

        public_send("#{name}=", value)
      end

      def assign_attributes(attribute_hash)
        attribute_hash.each do |name, value|
          assign_attribute(name, value)
        end
      end

      # Store attribute instance values separately
      def resource_attributes
        @resource_attributes ||= Marshal.load(Marshal.dump(self.class.resource_attributes))
      end

      def serialize_attributes
        Hash[resource_attributes.map { |k, v| [k, v.value] }]
      end
    end
  end
end