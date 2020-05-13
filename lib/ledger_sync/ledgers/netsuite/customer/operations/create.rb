# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        module Operations
          class Create < NetSuite::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).filled(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
                required(:subsidiary).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
