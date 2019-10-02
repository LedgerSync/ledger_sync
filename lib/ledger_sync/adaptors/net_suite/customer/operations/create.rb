module LedgerSync
  module Adaptors
    module QuickBooksOnline
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
              response = adaptor.upsert(
                resource: 'customer',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            end

            def local_resource_data
              {
                'DisplayName': resource.name,
                "PrimaryPhone": {
                  "FreeFormNumber": resource.phone_number
                },
                "PrimaryEmailAddr": {
                  "Address": resource.email
                }
              }
            end
          end
        end
      end
    end
  end
end
