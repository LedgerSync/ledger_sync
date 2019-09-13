module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:first_name).filled(:string)
                required(:last_name).filled(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'vendor',
                id: resource.ledger_id
              )

              response = adaptor.upsert(
                resource: 'vendor',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'name' => resource.name,
                'email' => resource.email
              }
            end
          end
        end
      end
    end
  end
end
