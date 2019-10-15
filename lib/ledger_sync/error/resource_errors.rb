module LedgerSync
  class ResourceError < Error
    attr_reader :resource

    def initialize(message:, resource:)
      @resource = resource
      super(message: message)
    end
    class AttributeTypeError < self
      attr_reader :attribute, :resource, :value

      def initialize(attribute:, resource:, value:)
        @attribute = attribute
        @resource = resource
        @value = value

        resource_class = resource.class

        message = attribute.type.error_message(
          attribute: attribute,
          resource: resource,
          value: value
        )

        super(message: message, resource: nil)
      end
    end

    class ReferenceAssignmentError < self
      def initialize(attribute:, resource:, value:)
        resource_class = resource.class
        message = "Attribute #{attribute} value for #{resource_class.name} should be a #{asdf}.  Given: #{value.class}"

        super(message: message, resource: resource)
      end
    end

    class MissingResourceError < self
      attr_reader :resource_type, :resource_external_id

      def initialize(message:, resource_type:, resource_external_id:)
        @resource_type = resource_type
        @resource_external_id = resource_external_id
        super(message: message, resource: nil)
      end
    end
  end
end
