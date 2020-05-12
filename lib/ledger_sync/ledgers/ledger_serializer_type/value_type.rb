# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module LedgerSerializerType
      class ValueType
        def convert_from_ledger(value:)
          value
        end

        def convert_from_local(value:)
          value
        end
      end
    end
  end
end
