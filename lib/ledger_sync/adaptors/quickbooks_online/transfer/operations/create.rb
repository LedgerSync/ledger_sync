module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Transfer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'transfer',
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
                'Amount' => resource.amount,
                'TxnDate' => resource.transaction_date.to_s, # Format: YYYY-MM-DD
                'PrivateNote' => resource.memo,
                'FromAccountRef' => {
                  'value' => resource.from_account.ledger_id
                },
                'ToAccountRef' => {
                  'value' => resource.to_account.ledger_id
                }
              }
            end
          end
        end
      end
    end
  end
end
