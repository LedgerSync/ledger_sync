module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:ledger_id).maybe(:string)
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
              response = adaptor.upsert(
                resource: 'payment',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
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
                'TotalAmt': resource.amount,
                'CurrencyRef': {
                  'value': resource.currency,
                },
                'CustomerRef': {
                  'value': resource.customer.ledger_id,
                }
              }
            end
          end
        end
      end
    end
  end
end
