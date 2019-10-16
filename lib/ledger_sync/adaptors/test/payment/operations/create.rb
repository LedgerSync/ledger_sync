module LedgerSync
  module Adaptors
    module Test
      module Payment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).value(:nil)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash(Types::Reference)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'payment',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('id')
              success(
                resource: Test::LedgerSerializer.new(resource: resource).deserialize(hash: response),
                response: response
              )
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
