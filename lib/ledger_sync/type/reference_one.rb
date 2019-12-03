# frozen_string_literal: true

module LedgerSync
  module Type
    class ReferenceOne < Value # :nodoc:
      include ValueMixin

      attr_reader :resource_class

      def initialize(resource_class:)
        @resource_class = resource_class
        super()
      end

      def error_message(attribute:, resource:, value:)
        if resource_class.is_a?(Array)
          "Attribute #{attribute.name} for #{resource.class.name} should be one of the following: #{resource_class.map(&:name).join(', ')}.  Given #{value.class.name}"
        else
          "Attribute #{attribute.name} for #{resource.class.name} should be a #{resource_class.name}.  Given #{value.class.name}"
        end
      end

      def type
        :reference_one
      end

      def valid_without_casting?(value:)
        return true if value.nil?
        return true if resource_classes.select { |e| value.is_a?(e) }.any?

        false
      end

      private

      def resource_classes
        @resource_classes ||= if resource_class.is_a?(Array)
                                resource_class
                              else
                                [resource_class]
                              end
      end
    end
  end
end
