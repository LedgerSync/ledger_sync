module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'customer',
                payload: serializer.to_h
              )

              success(
                resource: resource_serializer.deserialize(response),
                response: response
              )
            end
          end
        end
      end
    end
  end
end
