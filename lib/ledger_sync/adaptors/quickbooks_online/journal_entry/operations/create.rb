module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                optional(:currency).filled(:string)
                optional(:memo).filled(:string)
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
