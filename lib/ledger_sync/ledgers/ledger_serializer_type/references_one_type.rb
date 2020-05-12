# frozen_string_literal: true

require_relative 'value_type'

module LedgerSync
  module Ledgers
    module LedgerSerializerType
      class ReferencesOneType < ValueType
        def convert_from_ledger(resource_class: nil, serializer:, value:)
          return if value.nil?

          resource_class ||= serializer.inferred_resource_class
          serializer.new(resource: resource_class.new).deserialize(hash: value)
        end

        def convert_from_local(serializer:, value:)
          return if value.nil?

          serializer.new(resource: value).to_ledger_hash
        end
      end
    end
  end
end
