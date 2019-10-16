module LedgerSync
  module Adaptors
    module Test
      module Transfer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
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
