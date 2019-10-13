module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Invalid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:display_name).filled(:string)
                required(:first_name).filled(:string)
                required(:last_name).filled(:string)
                required(:email).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
