# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Subsidiary
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
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
