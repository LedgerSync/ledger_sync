# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        module Operations
          class Delete < NetSuite::Operation::Delete
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:undepFunds).maybe(:bool?)
                required(:payment).maybe(:float)
                required(:account).maybe(:hash, Types::Reference)
                required(:customer).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
