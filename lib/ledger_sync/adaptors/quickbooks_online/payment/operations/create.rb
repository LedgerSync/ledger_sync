# frozen_string_literal: true

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

            def operate
              response = adaptor.post(
                resource: 'payment',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(
                resource: ledger_serializer.deserialize(hash: response),
                response: response
              )
            end

            def local_resource_data
              {
                'TotalAmt' => resource.amount / 100.0,
                'CurrencyRef' => {
                  'value' => resource.currency
                },
                'CustomerRef' => {
                  'value' => resource.customer.ledger_id
                }
              }
            end
          end
        end
      end
    end
  end
end
