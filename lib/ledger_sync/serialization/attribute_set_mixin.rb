# frozen_string_literal: true

module LedgerSync
  class Serialization
    module AttributeSetMixin
      include Util::Mixins::DelegateIterableMethodsMixin

      attr_reader :attributes,
                  :serializer_class

      delegate_hash_methods_to :attributes

      def initialize(args = {})
        @attributes       = {}
        @serializer_class = args.fetch(:serializer_class)
      end

      def add(_attribute)
        raise NotImplementedError
      end

      def hash_attribute?(key)
        hash_attribute_keyed_hash.include?(key.to_s)
      end
    end
  end
end
