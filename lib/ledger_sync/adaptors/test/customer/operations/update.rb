module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                required(:name).filled(:string)
                optional(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'customer',
                id: resource.ledger_id
              )

              response = adaptor.post(
                resource: 'customer',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              success(response: response)
            end

            def local_resource_data
              {
                'name' => resource.name,
                'phone_number' => resource.phone_number,
                'email' => resource.email
              }
            end
          end
        end
      end
    end
  end
end
