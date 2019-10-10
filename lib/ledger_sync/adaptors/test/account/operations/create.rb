module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
                required(:account_sub_type).filled(:string)
                required(:number).maybe(:integer)
                required(:currency).maybe(:string)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end

            private

            def id
              SecureRandom.uuid
            end

            def local_resource_data
              {
                'name' => resource.name,
                'account_type' => resource.account_type,
                'account_sub_type' => resource.account_sub_type
              }
            end

            def operate
              response = adaptor.post(
                resource: 'account',
                payload: local_resource_data.merge(
                  'id' => id
                )
              )

              resource.ledger_id = response.dig('id')

              success(response: response)
            end
          end
        end
      end
    end
  end
end
