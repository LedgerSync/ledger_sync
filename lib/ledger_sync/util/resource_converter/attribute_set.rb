# frozen_string_literal: true

require_relative '../mixins/delegate_iterable_methods_mixin'

module LedgerSync
  module Util
    class ResourceConverter
      class AttributeSet
        include Mixins::DelegateIterableMethodsMixin

        attr_reader :attributes,
                    :resource_converter_class

        delegate_hash_methods_to :attributes

        def initialize(args = {})
          @attributes               = {}
          @resource_converter_class = args.fetch(:resource_converter_class)
        end

        def add(attribute)
          raise 'destination_attribute is missing' unless attribute.destination_attribute.present?

          if attributes.key?(attribute.destination_attribute.to_s)
            raise "destination_attribute already defined for #{serializer_class.name}: #{attribute.destination_attribute}"
          end

          @attributes[attribute.destination_attribute] = attribute
          attribute
        end

        def hash_attribute?(key)
          hash_attribute_keyed_hash.include?(key.to_s)
        end
      end
    end
  end
end
