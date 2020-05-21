# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                optional(:undepFunds).maybe(:bool?)
                optional(:payment).filled(:float)
                optional(:account).filled(:hash, Types::Reference)
                optional(:customer).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
