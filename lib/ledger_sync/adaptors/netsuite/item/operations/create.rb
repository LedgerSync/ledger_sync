# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Item
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
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
