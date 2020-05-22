# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:undepFunds).filled(:bool?)
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
