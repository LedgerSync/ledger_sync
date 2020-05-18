# frozen_string_literal: true

require_relative '../mixins/delegate_iterable_methods_mixin'

module LedgerSync
  module Util
    class ResourceConverter
      class AttributeSet
        include Mixins::DelegateIterableMethodsMixin

        attr_reader :attributes,
                    :resource_converter_class

        delegate_array_methods_to :attributes

        def initialize(args = {})
          @attributes               = []
          @attribute_keys           = {}
          @resource_converter_class = args.fetch(:resource_converter_class)
        end

        def add(attribute)
          unless attribute.destination_attribute.nil?
            if @attribute_keys.key?(attribute.destination_attribute.to_s)
              raise "destination_attribute already defined for #{resource_converter_class.name}: #{attribute.destination_attribute}"
            end

            @attribute_keys[attribute.destination_attribute] = attribute
          end

          attributes << attribute

          attribute
        end

        def hash_attribute?(key)
          hash_attribute_keyed_hash.include?(key.to_s)
        end
      end
    end
  end
end
