module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:display_name).maybe(:string)
                required(:first_name).maybe(:string)
                required(:last_name).maybe(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'vendor',
                id: resource.ledger_id
              )

              response = adaptor.post(
                resource: 'vendor',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              success(response: response)
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
