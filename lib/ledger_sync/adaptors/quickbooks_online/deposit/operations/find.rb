module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Deposit
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:currency).maybe(:string)
                required(:memo).maybe(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'deposit',
                id: resource.ledger_id
              )

              success(response: response)
            end
          end
        end
      end
    end
  end
end
