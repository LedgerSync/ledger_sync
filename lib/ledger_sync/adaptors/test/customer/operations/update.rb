module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                required(:name).filled(:string)
                optional(:phone_number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
