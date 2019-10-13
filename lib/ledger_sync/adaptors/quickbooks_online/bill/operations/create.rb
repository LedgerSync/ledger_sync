module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:vendor).hash(Types::Reference)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).maybe(:string)
                required(:transaction_date).maybe(:date?)
                required(:due_date).maybe(:date?)
                required(:line_items).array(Types::Reference)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'bill',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            end

            def local_resource_data
              {
                'CurrencyRef' => {
                  'value' => resource.currency,
                },
                'TxnDate' => resource.transaction_date.to_s, # Format: YYYY-MM-DD
                'DueDate' => resource.due_date.to_s, # Format: YYYY-MM-DD
                'PrivateNote' => resource.memo,
                'VendorRef' => {
                  'value' => resource.vendor.ledger_id,
                },
                'APAccountRef' => {
                  'value' => resource.account.ledger_id
                },
                'Line' => resource.line_items.map do |line_item|
                  {
                    'DetailType' => 'AccountBasedExpenseLineDetail',
                    'AccountBasedExpenseLineDetail' => {
                      'AccountRef' => {
                        'value' => line_item.account&.ledger_id
                      }
                    },
                    'Amount' => line_item.amount / 100.0,
                    'Description' => line_item.description
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
