# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'vendor',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(
                resource: ledger_serializer.deserialize(response),
                response: response
              )
            end

            def local_resource_data
              {
                'DisplayName' => resource.display_name,
                'GivenName' => resource.first_name,
                'FamilyName' => resource.last_name,
                'PrimaryEmailAddr' => {
                  'Address' => resource.email
                }
              }
            end
          end
        end
      end
    end
  end
end
