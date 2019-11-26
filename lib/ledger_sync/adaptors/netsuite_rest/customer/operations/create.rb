module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Customer
        module Operations
          class Create < NetSuiteREST::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
