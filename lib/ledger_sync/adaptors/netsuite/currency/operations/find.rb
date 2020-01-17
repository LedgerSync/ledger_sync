# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Currency
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
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
