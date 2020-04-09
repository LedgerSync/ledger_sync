# frozen_string_literal: true

require_relative './ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        class LedgerDeserializer < Invoice::LedgerSerializer
          id
        end
      end
    end
  end
end
