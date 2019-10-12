module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash(Types::Reference)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'payment',
                id: resource.ledger_id
              )
              response = adaptor.post(
                resource: 'payment',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(
                resource: ledger_serializer.deserialize(response),
                response: response
              )
            end

            def local_resource_data
              {
                'TotalAmt' => resource.amount / 100.0,
                'CurrencyRef' => {
                  'value' => resource.currency,
                },
                'CustomerRef' => {
                  'value' => resource.customer.ledger_id,
                }
              }
            end
          end
        end
      end
    end
  end
end
