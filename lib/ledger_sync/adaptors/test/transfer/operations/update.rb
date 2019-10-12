module LedgerSync
  module Adaptors
    module Test
      module Transfer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
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
