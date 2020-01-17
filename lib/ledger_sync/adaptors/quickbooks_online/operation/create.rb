# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        class Create
          include QuickBooksOnline::Operation::Mixin

          private

          def operate
            result(
              response: adaptor.post(
                path: ledger_resource_type_for_path,
                payload: ledger_serializer.to_ledger_hash
              )
            )
          end
        end
      end
    end
  end
end
