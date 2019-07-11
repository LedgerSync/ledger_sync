module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Invoice
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).maybe(:string)
                required(:currency).filled(:string)
                required(:customer).filled(Types::Reference)
                required(:line_items).maybe(:array)
                required(:number).maybe(:integer)
              end
            end

            private

            def operate
              response = adaptor.upsert(
                resource: 'invoice',
                payload: local_resource_data
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
                    # 'Id': '1',
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