module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).maybe(:integer)
                required(:currency).maybe(:hash, Types::Reference)
                required(:memo).maybe(:string)
                required(:transaction_date).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end
