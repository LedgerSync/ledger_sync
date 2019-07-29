module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Purchase
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:vendor).hash(Types::Reference)
                optional(:transaction_date).filled(:string)
                optional(:payment_type).filled(:string)
                optional(:memo).filled(:string)
              end
            end

            private

            def build
              build_vendor_operation
              add_root_operation(self)
            end

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'purchase',
                id: resource.ledger_id
              )
              response = adaptor.upsert(
                resource: 'purchase',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
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
