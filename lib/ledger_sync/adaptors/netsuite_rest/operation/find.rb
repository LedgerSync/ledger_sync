# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Find
          include NetSuiteREST::Operation::Mixin

          private

          def operate
            response = adaptor.get(
              path: ledger_serializer.class.api_resource_path(resource: resource)
            )

            # TODO: Raise NotFoundError when 404.  We probably should abstract out a request/response object.

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
