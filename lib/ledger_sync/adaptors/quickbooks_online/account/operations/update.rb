# frozen_string_literal: true

# https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/account
# Requires full update
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

              new_resource = ledger_serializer.deserialize(ledger_resource_data)
              new_serializer = ledger_serializer.class.new(resource: new_resource)

              pdb new_serializer.to_h

              response = adaptor.post(
                resource: 'account',
                payload: new_serializer.to_h
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