module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Valid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                optional(:ledger_id).maybe(:string)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
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
