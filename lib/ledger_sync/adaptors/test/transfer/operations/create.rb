module LedgerSync
  module Adaptors
    module Test
      module Transfer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
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

              resource.ledger_id = response.dig('id')
              success(response: response)
            end

            def local_resource_data
              {
                'amount' => resource.amount,
                'currency' => resource.currency,
                'from_account_id' => resource.from_account.ledger_id,
                'to_account_id' => resource.to_account.ledger_id,
                'date' => resource.transaction_date
              }
            end
          end
        end
      end
    end
  end
end
