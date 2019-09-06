module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
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

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'purchase',
                id: resource.ledger_id
              )

              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end
          end
        end
      end
    end
  end
end
