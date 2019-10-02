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

            def build
              build_customer_operation
              add_root_operation(self)
            end

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'payment',
                id: resource.ledger_id
              )
              response = adaptor.upsert(
                resource: 'payment',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

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
