# frozen_string_literal: true

module LedgerSync
  module QuickBooksOnline
    module Serialization
      module Type
        class MappingType < LedgerSync::Type::Value
          attr_reader :mapping

          def initialize(args = {})
            @mapping = args.fetch(:mapping)
          end

          def cast_value(args = {})
            value = args.fetch(:value)

            return if value.nil?

            mapping.fetch(:value)
          end
        end
      end
    end
  end
end
