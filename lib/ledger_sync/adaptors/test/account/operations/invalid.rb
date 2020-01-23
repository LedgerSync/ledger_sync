module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
                required(:classification).maybe(:string)
                required(:account_type).maybe(:string)
                required(:account_sub_type).maybe(:string)
                required(:number).maybe(:integer)
                required(:currency).maybe(:hash, Types::Reference)
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
