module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Deposit
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
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
