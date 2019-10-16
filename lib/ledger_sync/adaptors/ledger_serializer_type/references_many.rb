# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module LedgerSerializerType
      class ReferencesMany < Value
        def convert_from_ledger(resource_class: nil, serializer:, value:)
          resource_class ||= serializer._inferred_resource_class
          return [] if value.nil?

          value.map do |one_value|
            serializer.new(resource: resource_class.new).deserialize(hash: one_value)
          end
        end

        def convert_from_local(serializer:, value:)
          value.map do |one_value|
            serializer.new(resource: one_value).to_ledger_hash
          end
        end
      end
    end
  end
end
