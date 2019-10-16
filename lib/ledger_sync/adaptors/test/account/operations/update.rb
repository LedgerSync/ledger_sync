module LedgerSync
  module Adaptors
    module Test
      module Account
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
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

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'account',
                id: resource.ledger_id
              )

              find_serializer = Test::LedgerSerializer.new(resource: resource).deserialize(hash: ledger_resource_data)

              response = adaptor.post(
                resource: 'account',
                payload: find_serializer.to_h
              )

              success(
                resource: Test::LedgerSerializer.new(resource: resource).deserialize(hash: response),
                response: response
              )
            end

            def local_resource_data
              {
                'name' => resource.name,
                'account_type' => resource.account_type,
                'account_sub_type' => resource.account_sub_type
              }
            end
          end
        end
      end
    end
  end
end
