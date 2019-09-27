# frozen_string_literal: true

module LedgerSync
  class ResourceAttribute
    module Mixin
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def attribute(name, **keywords)
          name = name.to_sym
          raise "Attribute #{name} already exists on #{self.name}." if attributes.key?(name)

          class_eval do
            define_method name do
              attributes[name].value
            end

            define_method "#{name}=" do |val|
              unless attributes[name].valid_with?(value: val)
                raise ResourceError::AttributeTypeError.new(
                  attribute: name,
                  resource: self,
                  value: val
                )
              end

              attributes[name].value = val
              instance_variable_set("@#{name}", val)
            end
          end

          resource_attribute = ResourceAttribute.new(
            **{
              name: name,
              resource: self
            }.merge(keywords)
          )

          attributes.merge!(
            name.to_sym => resource_attribute
          )

          resource_attribute
        end

        def attributes
          @attributes ||= {}
        end

        def klass_from_resource_type(obj)
          LedgerSync.const_get(LedgerSync::Util::StringHelpers.camelcase(obj))
        end

        def reference(name, to: type)
          references[name.to_sym] = attribute(
            name,
            reference: true,
            type: to
          )
        end

        def references
          @references ||= {}
        end

        def reference_klass(name)
          references[name.to_sym]
        end

        def reference_resource_type(name)
          reference_klass(name).resource_type
        end
      end

      def initialize(*)
        # Store attribute instance values separately
        @attributes = Marshal.load(Marshal.dump(self.class.attributes))
        @references = Marshal.load(Marshal.dump(self.class.references))

        # Initialize empty values
        attributes.keys.each { |e| instance_variable_set("@#{e}", nil) }

        super()
      end

      def attributes
        @attributes
      end

      def references
        @references
      end

      def serialize_attributes
        Hash[attributes.map { |k, v| [k, v.value] }]
      end
    end

    TYPES = {
      date: [Date],
      date_time: [DateTime],
      float: [Float],
      integer: [Integer],
      number: [Integer, Float],
      string: [String],
      symbol: [Symbol]
    }.freeze

    attr_accessor :value
    attr_reader :name,
                :reference,
                :resource,
                :type

    def initialize(name:, reference: false, resource:, type:, value: nil)
      @name = name
      @reference = reference
      @resource = resource

      if type.is_a?(String) || type.is_a?(Symbol)
        @type = type.to_sym
        raise "Invalid type: #{type}.  Expected #{types.keys.sort.join(', ')}" unless types.keys.include?(type)
      else
        @type = type
      end

      @value = value
    end

    def reference?
      reference == true
    end

    def types
      self.class.types
    end

    def valid_with?(value:)
      return true if value.nil?
      return true if valid_classes.select { |e| value.is_a?(e) }.any?

      false
    end

    def valid_classes
      case type
      when Symbol
        types[type]
      when Array
        type
      else
        [type]
      end
    end

    def self.types
      TYPES
    end
  end
end
