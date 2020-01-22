module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:currency).hash(Types::Reference)
                required(:ledger_id).value(:nil)
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
