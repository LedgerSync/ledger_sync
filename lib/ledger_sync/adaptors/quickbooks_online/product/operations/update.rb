module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Product
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                optional(:description).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'item',
                id: resource.ledger_id
              )

              response = adaptor.upsert(
                resource: 'item',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'Name': @resource.name,
                'Description': @resource.description,
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
