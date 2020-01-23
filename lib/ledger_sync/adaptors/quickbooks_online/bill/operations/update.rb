module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:currency).hash(Types::Reference)
                optional(:due_date).maybe(:date?)
                required(:line_items).array(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:memo).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).maybe(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
