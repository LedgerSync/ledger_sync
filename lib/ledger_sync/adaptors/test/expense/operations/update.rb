module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:entity).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
                required(:reference_number).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
