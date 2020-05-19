# frozen_string_literal: true

module LedgerSync
  module Util
    class ResourceConverter
      module Type
        class ReferencesManyType < ResourceConverterType
          def cast_value(args = {})
            destination = args.fetch(:destination)
            values = args.fetch(:value)

            return if values.nil?

            values.map do |value|
              super(
                destination: destination,
                value: value
              )
            end
          end
        end
      end
    end
  end
end
