# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        module Operations
          class Update < NetSuite::Operation::Update
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:email).maybe(:string)
                required(:companyName).filled(:string)
                required(:firstName).maybe(:string)
                required(:lastName).maybe(:string)
                required(:phone).maybe(:string)
                required(:subsidiary).filled(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
