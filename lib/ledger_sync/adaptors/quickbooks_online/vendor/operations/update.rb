# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'vendor',
                id: resource.ledger_id
              )

              response = adaptor.post(
                resource: 'vendor',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
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
