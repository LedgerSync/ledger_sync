# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:currency).hash(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                optional(:reference_number).filled(:string)
                optional(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
