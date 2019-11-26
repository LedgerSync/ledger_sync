module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Customer
        module Operations
          class Find < NetSuiteREST::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
