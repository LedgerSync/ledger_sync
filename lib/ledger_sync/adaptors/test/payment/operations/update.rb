module LedgerSync
  module Adaptors
    module Test
      module Payment
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash do
                  required(:object).filled(:symbol)
                  required(:id).filled(:string)
                end
              end
            end
          end
        end
      end
    end
  end
end
