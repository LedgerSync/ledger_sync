module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                optional(:currency).maybe(:string)
                optional(:memo).maybe(:string)
                optional(:transaction_date).filled(:date?)
                optional(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
