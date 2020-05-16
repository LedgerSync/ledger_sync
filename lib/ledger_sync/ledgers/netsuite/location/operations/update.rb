# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Location
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
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
