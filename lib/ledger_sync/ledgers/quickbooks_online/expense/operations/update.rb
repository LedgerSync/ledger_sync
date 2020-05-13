module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:account).hash(Types::Reference)
                optional(:currency).hash(Types::Reference)
                required(:department).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                required(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                required(:payment_type).filled(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).filled(:date?)
                optional(:entity).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
