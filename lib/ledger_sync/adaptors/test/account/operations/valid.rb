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
                required(:account_type).filled(:string)
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