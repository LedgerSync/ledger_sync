# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      module Subsidiary
        module Operations
          class Find < NetSuiteSOAP::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
                required(:state).maybe(:string)
              end
            end

            private

            def operate
              netsuite_resource = ::NetSuite::Records::Subsidiary.get(
                internal_id: resource.ledger_id
              )

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
