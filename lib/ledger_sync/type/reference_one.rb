# frozen_string_literal: true

require_relative 'value'

module LedgerSync
  module Type
    class ReferenceOne < Value # :nodoc:
      include ValueMixin

      attr_reader :resource_class

      def initialize(resource_class:)
        @resource_class = resource_class
        super()
      end

      def type
        :reference_one
      end

      def resource_classes
        @resource_classes ||= if resource_class.is_a?(Array)
                                resource_class
                              else
                                [resource_class]
        end
      end

      private

      def valid_classes
        resource_classes
      end
    end
  end
end
