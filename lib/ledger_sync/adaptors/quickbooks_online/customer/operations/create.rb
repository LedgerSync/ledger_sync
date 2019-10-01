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
                payload: local_resource_data
              )

              Serializer.new(resource: resource).deserialize!(response)

              success(response: response)
            end

            def local_resource_data
              Serializer.new(resource: resource).to_h
            end
          end
        end
      end
    end
  end
end
