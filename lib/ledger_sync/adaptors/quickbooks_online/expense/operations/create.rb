module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:vendor).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:string)
                required(:transactions).array(:hash) do
                  required(:amount).filled(:integer)
                  required(:description).maybe(:string)
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
