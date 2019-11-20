# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Subsidiary
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
              end
            end

            private

            def operate
              netsuite_resource = ::NetSuite::Records::Subsidiary.new(
                external_id: resource.external_id,
                name: resource.name
              )

              netsuite_resource.add

              raise 'Could not create subsidiary.' unless netsuite_resource

              resource.name = netsuite_resource.name
              resource.ledger_id = netsuite_resource.internal_id

              success(
                resource: resource,
                response: netsuite_resource
              )
            end
          end
        end
      end
    end
  end
end
