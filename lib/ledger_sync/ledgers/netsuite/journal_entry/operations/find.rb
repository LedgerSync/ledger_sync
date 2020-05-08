# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:memo).maybe(:string)
                optional(:trandate).maybe(:string)
                optional(:tranId).maybe(:string)
                optional(:currency).maybe(:hash, Types::Reference)
                optional(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
