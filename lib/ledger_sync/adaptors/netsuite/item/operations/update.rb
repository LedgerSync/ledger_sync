# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Item
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
