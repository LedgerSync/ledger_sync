# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer
        module Operations
          class Create < TestLedger::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                optional(:name).filled(:string)
                optional(:email).maybe(:string)
                optional(:date).maybe(:string)
                required(:subsidiaries).maybe(:hash, Types::Reference)
                required(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
