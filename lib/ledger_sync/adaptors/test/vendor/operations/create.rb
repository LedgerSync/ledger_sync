module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).value(:nil)
                required(:first_name).filled(:string)
                required(:last_name).filled(:string)
                required(:email).maybe(:string)
              end
            end

            private

            def id
              SecureRandom.uuid
            end

            def local_resource_data
              {
                'name' => resource.name,
                'email' => resource.email
              }
            end

            def operate
              response = adaptor.post(
                resource: 'vendor',
                payload: local_resource_data.merge(
                  'id' => id
                )
              )

              resource.ledger_id = response.dig('id')

              success(response: response)
            end
          end
        end
      end
    end
  end
end
