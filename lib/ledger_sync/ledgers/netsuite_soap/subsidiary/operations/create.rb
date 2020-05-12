# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      module Subsidiary
        module Operations
          class Create < NetSuiteSOAP::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
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
