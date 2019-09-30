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
        valid_types = resource.class.attributes[attribute].valid_classes

        message = "Attribute #{attribute} for #{resource_class.name} should be one of the following: #{valid_types.join(', ')}.  Given: #{value.class}"

        super(message: message, resource: nil)
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
