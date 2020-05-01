# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeError < Error
    class TypeError < self
      attr_reader :attribute, :resource_class, :value

      def initialize(args = {})
        @attribute = args.fetch(:attribute)
        @resource_class = args.fetch(:resource_class)
        @value = args.fetch(:value)

        message = attribute.type.error_message(args)

        super(message: message)
      end
    end
  end

  class ResourceError < Error
    attr_reader :resource

    def initialize(message:, resource:)
      @resource = resource
      super(message: message)
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
