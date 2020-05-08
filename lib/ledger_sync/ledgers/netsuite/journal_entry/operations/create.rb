# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:memo).maybe(:string)
                required(:trandate).maybe(:string)
                required(:tranId).maybe(:string)
                required(:currency).maybe(:hash, Types::Reference)
                required(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
