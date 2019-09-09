module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'account',
                id: resource.ledger_id
              )

              response = adaptor.upsert(
                resource: 'account',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'name': resource.name,
                "account_type": resource.account_type
              }
            end
          end
        end
      end
    end
  end
end
