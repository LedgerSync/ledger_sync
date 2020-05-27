# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerDepartmentType < LedgerSync::Type::Value
          def initialize(args = {})
            @department_class = args.fetch(:department_class)
          end

          private

          def cast_value(args = {})
            value = args.fetch(:value)

            return if value.nil?

            @department_class.new(
              ledger_id: value.fetch('id', nil)
            )
          end

          def valid_classes
            [
              Hash
            ]
          end
        end
      end
    end
  end
end
