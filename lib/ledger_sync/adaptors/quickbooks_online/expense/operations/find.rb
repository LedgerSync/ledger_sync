module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:account).hash(Types::Reference)
                required(:currency).maybe(:string)
                required(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                required(:line_items).array(Types::Reference)
                required(:memo).maybe(:string)
                required(:payment_type).maybe(:string)
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
