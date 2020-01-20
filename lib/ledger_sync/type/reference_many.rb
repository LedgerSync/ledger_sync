# frozen_string_literal: true

module LedgerSync
  module Type
    class ReferenceMany < Value # :nodoc:
      include ValueMixin

      attr_reader :resource_class

      def initialize(resource_class:)
        @resource_class = resource_class
        super()
      end

      def error_message(attribute:, resource:, value:)
        return super unless value.is_a?(Array)

        invalid_classes = value.reject { |e| e.is_a?(resource_class) }.map(&:class)
        "Attribute #{attribute.name} for #{resource.class.name} should be an array of #{resource_class.name}.  Given array containing: #{invalid_classes.join(', ')}"
      end

      def type
        :reference_many
      end

      def valid_without_casting?(value:)
        return false unless value.is_a?(Array)
        return true if (resource_classes & value.map(&:class)).any?
        return true if value.is_a?(Array) && value.empty?

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
