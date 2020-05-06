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
        def _add_resource_attribute(resource_attribute)
          _define_attribute_methods(resource_attribute.name)

          resource_attributes.add(resource_attribute)
          references_many_resource_attributes << resource_attribute if resource_attribute.type.is_a?(Reference::Many)

          resource_attribute
        end

        def _define_attribute_methods(name)
          class_eval do
            define_attribute_methods name

            define_method name do
              resource_attributes[name].value
            end

            define_method "#{name}=" do |val|
              resource_attribute = resource_attributes[name]
              public_send("#{name}_will_change!") if resource_attribute.will_change?(val) # For Dirty
              resource_attribute.value = val
            end

            simply_serialize attributes: [name]
          end
        end

        def attribute(name, type:)
          _add_resource_attribute(ResourceAttribute.new(name: name, resource_class: self, type: type))
        end

        def references_many_resource_attributes
          @references_many_resource_attributes ||= []
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

      def save
        resoure_attributes.map(&:save)
        super
      end

      def serialize_attributes
        Hash[resource_attributes.map { |k, v| [k, v.value] }]
      end
    end
  end
end
