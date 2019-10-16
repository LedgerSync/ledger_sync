module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Valid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                optional(:ledger_id).maybe(:string)
                required(:name).filled(:string)
                required(:classification).filled(:string)
                required(:account_type).filled(:string)
                required(:account_sub_type).filled(:string)
                required(:number).maybe(:integer)
                required(:currency).maybe(:string)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end

            private

            def operate
              success(response: :foo)
            end
          end
        end
      end
    end
  end
end
