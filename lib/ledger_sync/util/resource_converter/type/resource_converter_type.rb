# frozen_string_literal: true

module LedgerSync
  module Util
    class ResourceConverter
      module Type
        class ResourceConverterType < LedgerSync::Type::Value
          attr_reader :resource_converter

          def initialize(args = {})
            @resource_converter = args.fetch(:resource_converter)
          end

          def cast_value(args = {})
            destination = args.fetch(:destination)
            source      = args.fetch(:value)

            return if source.nil?

            resource_converter.new.convert(destination: destination, source: source)
          end
        end
      end
    end
  end
end
