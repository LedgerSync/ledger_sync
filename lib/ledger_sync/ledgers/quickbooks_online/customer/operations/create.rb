# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:DisplayName).maybe(:string)
                required(:FamilyName).maybe(:string)
                required(:GivenName).maybe(:string)
                required(:MiddleName).maybe(:string)
                required(:PrimaryEmailAddr).maybe(:hash, Types::Reference)
                required(:PrimaryPhone).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
