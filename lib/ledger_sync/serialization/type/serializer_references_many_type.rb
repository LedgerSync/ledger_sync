# frozen_string_literal: true

require_relative 'serializer_type'

module LedgerSync
  module Serialization
    module Type
      class SerializerReferencesManyType < SerializerType
        def cast_value(args = {})
          value = args.fetch(:value)

          return if value.nil?

          value.map do |one_value|
            super(value: one_value)
          end
        end
      end
    end
  end
end
