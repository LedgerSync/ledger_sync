module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'customer',
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
