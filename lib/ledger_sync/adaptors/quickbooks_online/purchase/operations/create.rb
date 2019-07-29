module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Purchase
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:ledger_id).maybe(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                optional(:transaction_date).maybe(:string)
                optional(:payment_type).maybe(:string)
                optional(:memo).maybe(:string)
                required(:vendor).hash do
                  required(:object).filled(:symbol)
                  required(:id).filled(:string)
                end
              end
            end

            private

            def build
              build_vendor_operation
              add_root_operation(self)
            end

            def operate
              response = adaptor.upsert(
                resource: 'purchase',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def build_vendor_operation
              vendor = Vendor::Operations::Upsert.new(
                adaptor: adaptor,
                resource: resource.vendor
              )

              add_before_operation(vendor)
            end

            def local_resource_data
              {
                'CurrencyRef': {
                  'value': resource.currency,
                },
                'PaymentType': resource.payment_type,
                'TxnDate': resource.transaction_date,
                'PrivateNote': resource.memo,
                'EntityRef': {
                  'value': resource.vendor.ledger_id,
                },
                'Line': [
                  {
                    'AccountBasedExpenseLineDetail': {
                      'AccountRef': {
                        'value': '4'
                      }
                    },
                    'Amount': resource.amount,
                    'DetailType': 'AccountBasedExpenseLineDetail',
                    'Description': 'Some description'
                  }
                ],
                'AccountRef': {
                  'value': '4'
                }
              }
            end
          end
        end
      end
    end
  end
end
