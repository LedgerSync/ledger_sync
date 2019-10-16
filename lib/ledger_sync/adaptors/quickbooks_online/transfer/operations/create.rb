module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Transfer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
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
