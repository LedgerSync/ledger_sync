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

        value.reject { |e| e.is_a?(resource_class) }.empty?
      end
    end
  end
end
