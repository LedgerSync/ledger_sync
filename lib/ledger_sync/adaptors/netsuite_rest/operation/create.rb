# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Create
          include NetSuiteREST::Operation::Mixin

          private

          def operate
            response = adaptor.post(
              body: ledger_serializer.to_ledger_hash,
              path: ledger_serializer.class.api_resource_path
            )

            pdb response

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
