module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
              end
            end

            private

            def operate
              response = adaptor.upsert(
                resource: 'account',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            end

            def local_resource_data
              {
                'Name': resource.name,
                "AccountType": resource.account_type
              }
            end
          end
        end
      end
    end
  end
end
