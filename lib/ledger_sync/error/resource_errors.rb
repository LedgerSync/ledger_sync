# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeError < Error
    class TypeError < self
      attr_reader :attribute, :resource_class, :value

      def initialize(args = {})
        @attribute      = args.fetch(:attribute)
        @resource_class = args.fetch(:resource_class)
        @value          = args.fetch(:value)

        super(message: generate_message)
      end

      private

      def generate_message # rubocop:disable Metrics/PerceivedComplexity
        ret = "Attribute #{attribute.name} for #{resource_class.name} should be "

        ret += case attribute
               when LedgerSync::ResourceAttribute::Reference::Many
                 invalid_classes = value.reject { |e| e.is_a?(type_resource_class) }.map(&:class)
                 if type_resource_class.is_a?(Array)
                   "an array of one or more of the following: #{type_resource_class.name}.  Given array containing: " \
                     "#{invalid_classes.join(', ')}"
                 else
                   "an array of #{type_resource_class.name}.  Given array containing: #{invalid_classes.join(', ')}"
                 end
               else
                 if type_resource_class.is_a?(Array)
                   "one of the following: #{type_resource_class.map(&:name).join(', ')}.  Given #{value.class.name}"
                 else
                   "a #{type_resource_class.name}.  Given #{value.class.name}"
                 end
               end

        ret
      end

      def type_resource_class
        @type_resource_class ||= if attribute.is_a?(LedgerSync::ResourceAttribute::Reference)
                                   attribute.type.resource_class
                                 else
                                   attribute.type.valid_classes
                                 end
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
