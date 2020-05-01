# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerSerializerType
        class ActiveType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return if value.nil?

            case value
            when "F"
              true
            when "T"
              false
            end
          end

          def convert_from_local(value:)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
