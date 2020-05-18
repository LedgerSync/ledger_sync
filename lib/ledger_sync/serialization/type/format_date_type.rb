# frozen_string_literal: true

module LedgerSync
  module Serialization
    module Type
      class FormatDateType < LedgerSync::Type::Value
        attr_reader :format

        def initialize(args = {})
          @format = args.fetch(:format)
        end

        def cast_value(args = {})
          value = args.fetch(:value)

          return if value.nil?

          value.to_datetime.strftime(format)
        end
      end
    end
  end
end
