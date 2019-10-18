module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def id
              SecureRandom.uuid
            end

            def local_resource_data
              {
                'name' => resource.name,
                'phone_number' => resource.phone_number,
                'email' => resource.email
              }
            end

            def operate
              response = adaptor.post(
                resource: 'customer',
                payload: local_resource_data.merge(
                  'id' => id
                )
              )

              resource.ledger_id = response.dig('id')

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
