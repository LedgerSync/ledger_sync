module LedgerSync
  module Adaptors
    module Test
      module Payment
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash do
                  required(:object).filled(:symbol)
                  required(:id).filled(:string)
                end
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

              success(response: response)
            end

            def local_resource_data
              {
                'amount' => resource.amount,
                'currency' => resource.currency,
                'customer_id' => resource.customer.ledger_id
              }
            end
          end
        end
      end
    end
  end
end
