module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                required(:line_items).array(Types::Reference)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:reference_number).maybe(:string)
                required(:transaction_date).filled(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
