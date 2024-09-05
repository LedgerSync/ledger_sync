# frozen_string_literal: true

require_relative 'value'

module LedgerSync
  module Type
    class ReferenceMany < Value # :nodoc:
      include ValueMixin

      attr_reader :resource_class

      def initialize(resource_class:)
        @resource_class = resource_class
        super()
      end

      def cast(args = {})
        value = args.fetch(:value)
        default = args.fetch(:default, nil)

        pd default
        return default if value.nil?

        many_array_class = LedgerSync::ResourceAttribute::Reference::Many::ManyArray

        return value if value.is_a?(many_array_class)
        unless value.is_a?(Array)
          raise "Cannot convert #{value.class} to LedgerSync::ResourceAttribute::Reference::Many::ManyArray"
        end

        many_array_class.new(value)
      end

      def type
        :reference_many
      end

      def valid?(args = {})
        value = args.fetch(:value, args.fetch(:default, nil))

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
