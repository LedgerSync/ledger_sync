module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Transfer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:hash, Types::Reference)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
