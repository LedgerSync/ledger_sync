module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Deposit
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
