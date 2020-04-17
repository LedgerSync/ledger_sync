# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Item
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
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
