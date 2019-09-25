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
                required(:number).maybe(:integer)
                required(:currency).maybe(:string)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end
          end
        end
      end
    end
  end
end
