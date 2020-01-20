module LedgerSync
  module Adaptors
    module Test
      module Payment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:customer).hash(Types::Reference)
                optional(:deposit_account).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).filled(:date?)
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
