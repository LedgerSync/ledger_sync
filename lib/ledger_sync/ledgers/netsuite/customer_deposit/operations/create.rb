# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:undepFunds).maybe(:bool?)
                required(:payment).filled(:float)
                required(:account).filled(:hash, Types::Reference)
                required(:customer).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
