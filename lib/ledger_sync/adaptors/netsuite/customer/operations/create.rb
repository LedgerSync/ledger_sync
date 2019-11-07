module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              customer = NetSuite::Records::Customer.new(

              )

              resource.ledger_id = response.dig('Id')
              success(
                response: response,
                resource: resource
              )
            end
          end
        end
      end
    end
  end
end
