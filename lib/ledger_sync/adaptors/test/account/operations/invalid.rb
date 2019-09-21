module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
                required(:account_type).maybe(:string)
                required(:account_sub_type).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
