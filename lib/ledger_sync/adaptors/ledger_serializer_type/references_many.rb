# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module LedgerSerializerType
      class ReferencesMany < Value
        private

        def convert_from_ledger
          value.map do |one_value|
            serializer.new(resource: resource_class.new).deserialize(one_value)
          end
        end

        def convert_from_local
          value.map do |one_value|
            serializer.new(resource: one_value).to_h
          end
        end

        def resource_class
          @resource_class = resource.class.resource_attributes[attribute.to_sym].type.resource_class
        end
      end
    end
  end
end
