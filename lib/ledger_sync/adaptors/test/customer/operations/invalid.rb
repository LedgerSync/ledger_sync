module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:email).filled(:string)
                required(:name).filled(:string)
                required(:phone_number).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
