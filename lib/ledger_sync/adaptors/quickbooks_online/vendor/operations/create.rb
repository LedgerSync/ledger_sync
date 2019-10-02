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
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
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
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
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
