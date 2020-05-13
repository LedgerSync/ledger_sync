# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Location
        module Operations
          class Delete < NetSuite::Operation::Delete
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
