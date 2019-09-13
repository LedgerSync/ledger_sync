# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'customer',
                id: resource.ledger_id
              )
              response = adaptor.upsert(
                resource: 'customer',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'DisplayName' => resource.name,
                "PrimaryPhone" => {
                  "FreeFormNumber" => resource.phone_number
                },
                "PrimaryEmailAddr" => {
                  "Address" => resource.email
                }
              }
            end
          end
        end
      end
    end
  end
end