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

            def find_operation_result
              op = Find.new(
                adaptor: adaptor,
                resource: resource
              )
              op.validate
               .and_then { op.perform }
            end

            def operate
              find_operation_result
                .and_then { |find_result| update_customer(find_result) }
            end

            def update_customer(find_result)
              response = adaptor.upsert(
                resource: 'customer',
                payload: find_result.resource.assign_attributes(resource.changes_to_h)
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
