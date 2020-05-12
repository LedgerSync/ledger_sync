module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Invoice
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:customer).hash(Types::Reference)
                optional(:deposit).maybe(:integer)
                required(:ledger_id).filled(:string)
                required(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                optional(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
