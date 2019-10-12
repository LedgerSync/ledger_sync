module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:account_sub_type).filled(:string)
                required(:account_type).filled(:string)
                required(:active).maybe(:bool)
                required(:currency).maybe(:string)
                required(:description).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:number).maybe(:integer)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'account',
                payload: ledger_serializer.to_h
              )

              success(
                resource: ledger_serializer.deserialize(response),
                response: response
              )
            end
          end
        end
      end
    end
  end
end
