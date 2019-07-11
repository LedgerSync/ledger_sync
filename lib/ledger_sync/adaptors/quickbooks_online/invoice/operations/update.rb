module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Invoice
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:currency).filled(:string)
                required(:customer).filled(Types::Reference)
                required(:line_items).maybe(:array)
                required(:number).maybe(:integer)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'payment',
                id: resource.ledger_id
              )

              response = adaptor.upsert(
                resource: 'payment',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'CurrencyRef': {
                  'value': resource.currency,
                },
                'CustomerRef': {
                  'value': resource.customer,
                },
                'DocNumber': resource.number,
                'Line': resource.line_items.each_with_index.map do |line, i|
                  {
                    'LineNum': i,
                    'Amount': line.fetch(:amount),
                    'SalesItemLineDetail': {
                      'TaxCodeRef': {
                        'value': 'NON'
                      },
                      'ItemRef': {
                        'value': line.fetch(:product)
                      }
                    },
                    'DetailType': 'SalesItemLineDetail'
                  }
                end
              }
            end
          end
        end
      end
    end
  end
end
