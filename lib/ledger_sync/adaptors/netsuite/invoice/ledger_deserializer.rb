# frozen_string_literal: true

require_relative './ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        class LedgerDeserializer < Invoice::LedgerSerializer
          id

          # attribute ledger_attribute: 'entity.id',
          #           resource_attribute: 'customer.ledger_id',
          #           serialize: false
        end
      end
    end
  end
end
