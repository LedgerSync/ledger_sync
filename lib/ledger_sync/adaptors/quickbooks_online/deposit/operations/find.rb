module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Deposit
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:currency).maybe(:string)
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
