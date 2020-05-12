module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Deposit
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
                required(:memo).maybe(:string)
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
