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
                required(:state).filled(:string)
              end
            end

            private

            def operate
              netsuite_resource = ::NetSuite::Records::Subsidiary.new(
                external_id: resource.external_id,
                name: resource.name,
                state: resource.state
              )

              return netsuite_failure(netsuite_resource: netsuite_resource) unless netsuite_resource.add

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
