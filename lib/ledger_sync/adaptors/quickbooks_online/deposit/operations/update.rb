module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Deposit
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'deposit',
                id: resource.ledger_id
              )
              response = adaptor.post(
                resource: 'deposit',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
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
                'PrivateNote' => resource.memo,
                'ExchangeRate' => resource.exchange_rate,
                'DepositToAccountRef' => {
                  'value' => resource.account.ledger_id
                },
                'Line' => resource.line_items.map do |line_item|
                  {
                    'DetailType' => 'DepositLineDetail',
                    'DepositLineDetail' => {
                      'AccountRef' => {
                        'value' => line_item.account&.ledger_id || resource.account.ledger_id
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
