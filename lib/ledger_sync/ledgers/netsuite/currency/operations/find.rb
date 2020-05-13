# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Currency
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
                required(:symbol).maybe(:string)
                required(:exchange_rate).maybe(:float)
              end
            end
          end
        end
      end
    end
  end
end
