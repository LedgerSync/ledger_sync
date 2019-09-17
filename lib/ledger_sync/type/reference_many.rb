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

      def type
        :reference_many
      end

      def valid_without_casting?(value:)
        return false unless value.is_a?(Array)
        return true if value.reject { |e| e.is_a?(resource_class) }.empty?

        false
      end
    end
  end
end
