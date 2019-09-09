module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
