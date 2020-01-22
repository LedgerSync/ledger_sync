module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:currency).maybe(:hash, Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
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
