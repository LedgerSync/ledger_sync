# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:email).maybe(:string)
                required(:companyName).maybe(:string)
                required(:firstName).maybe(:string)
                required(:lastName).maybe(:string)
                required(:phone).maybe(:string)
                required(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
