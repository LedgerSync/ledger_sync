# frozen_string_literal: true

module LedgerSync
  module Serialization
    module Type
      class MappingType < LedgerSync::Type::Value
        attr_reader :hash

        def initialize(args = {})
          @hash = args.fetch(:hash)
        end

        def cast_value(args = {})
          value = args.fetch(:value)

          return if value.nil?

          hash.fetch(value)
        end
      end
    end
  end
end
