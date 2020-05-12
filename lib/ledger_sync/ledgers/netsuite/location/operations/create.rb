# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Location
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
