module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:first_name).maybe(:string)
                required(:last_name).maybe(:string)
              end
            end

            private

            def operate
              response = adaptor.upsert(
                resource: 'vendor',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            end

            def local_resource_data
              {
                'GivenName': resource.first_name,
                'FamilyName': resource.last_name
              }
            end
          end
        end
      end
    end
  end
end
