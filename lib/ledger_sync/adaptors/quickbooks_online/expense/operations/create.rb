module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:account).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:exchange_rate).maybe(:float)
                required(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'purchase',
                payload: serializer.to_h
              )

              success(
                resource: serializer.deserialize(response),
                response: response
              )
            end
          end
        end
      end
    end
  end
end
