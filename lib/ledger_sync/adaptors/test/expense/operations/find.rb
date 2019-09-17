module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:vendor).hash(Types::Reference)
                required(:amount).maybe(:integer)
                required(:currency).maybe(:string)
                required(:memo).maybe(:string)
                required(:payment_type).maybe(:string)
                required(:transaction_date).maybe(:date?)
                required(:line_items).array(Types::Reference)
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
