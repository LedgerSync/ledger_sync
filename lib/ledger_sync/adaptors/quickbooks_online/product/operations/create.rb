module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Product
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                optional(:description).maybe(:string)
              end
            end

            private

            def operate
              response = adaptor.upsert(
                resource: 'item',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'Name': resource.name,
                'Description': resource.description,
                'Type': 'Service',
                'IncomeAccountRef': {
                  'value': '1',
                  'name': 'Services'
                }
              }
            end
          end
        end
      end
    end
  end
end
