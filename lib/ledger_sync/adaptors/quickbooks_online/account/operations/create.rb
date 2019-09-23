require 'ledger_sync/adaptors/quickbooks_online/account/mapping'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
                required(:account_sub_type).filled(:string)
              end
            end

            private

            def operate
              response = adaptor.upsert(
                resource: 'account',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'Name' => resource.name,
                'AccountType' => Mapping::ACCOUNT_TYPES[resource.account_type],
                'AccountSubType' => Mapping::ACCOUNT_SUB_TYPES[resource.account_sub_type]
              }
            end
          end
        end
      end
    end
  end
end
