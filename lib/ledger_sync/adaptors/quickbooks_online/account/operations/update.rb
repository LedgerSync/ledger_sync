# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
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

              response = adaptor.post(
                resource: 'account',
                payload: ledger_serializer.deserialize(ledger_resource_data).to_h
              )

              success(
                resource: ledger_serializer.deserialize(response),
                response: response
              )
            end
          end
        end
      end
    end
  end
end