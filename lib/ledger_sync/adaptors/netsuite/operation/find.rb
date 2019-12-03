# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        class Find
          include NetSuite::Operation::Mixin

          private

          def operate
            return failure(nil) if resource.ledger_id.nil?

            response = adaptor.find(
              resource: netsuite_online_resource_type,
              id: resource.ledger_id
            )

            success(
              resource: ledger_serializer.deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
