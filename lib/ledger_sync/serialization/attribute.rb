# frozen_string_literal: true

Gem.find_files('ledger_sync/serialization/type/**/*.rb').each { |path| require path }

module LedgerSync
  class Serialization
    class Attribute
      attr_reader :block,
                  :hash_attribute,
                  :resource_attribute,
                  :resource_class,
                  :type

      def initialize(args = {})
        @block              = args.fetch(:block, nil)
        @hash_attribute     = args.fetch(:hash_attribute, nil).try(:to_s)
        @resource_attribute = args.fetch(:resource_attribute, nil).try(:to_s)
        @resource_class     = args.fetch(:resource_class, nil)
        @type               = args.fetch(:type, nil) || LedgerSync::Type::Value.new
      end

      def block_value_for(args = {})
        block.call(args.merge(attribute: self))
      end

      def hash_attribute_dot_parts
        @hash_attribute_dot_parts ||= hash_attribute.split('.')
      end

      def reference?
        references_many? || references_one?
      end

      def references_many?
        type.is_a?(Type::ReferencesManyType)
      end

      def references_one?
        type.is_a?(Type::ReferencesOneType)
      end

      def resource_attribute_dot_parts
        @resource_attribute_dot_parts ||= resource_attribute.split('.')
      end
    end
  end
end
