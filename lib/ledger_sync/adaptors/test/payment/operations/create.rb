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

            def build
              build_customer_operation
              add_root_operation(self)
            end

            def operate
              response = adaptor.upsert(
                resource: 'payment',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def build_customer_operation
              customer = Customer::Operations::Upsert.new(
                adaptor: adaptor,
                resource: resource.customer
              )

              add_before_operation(customer)
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
