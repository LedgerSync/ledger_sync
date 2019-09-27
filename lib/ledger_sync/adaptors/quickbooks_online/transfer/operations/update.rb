module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Transfer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
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
              ledger_resource_data = adaptor.find(
                resource: 'transfer',
                id: resource.ledger_id
              )
              response = adaptor.post(
                resource: 'transfer',
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
