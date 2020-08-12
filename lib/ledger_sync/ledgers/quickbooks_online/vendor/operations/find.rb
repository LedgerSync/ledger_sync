# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:CompanyName).maybe(:string)
                optional(:DisplayName).maybe(:string)
                optional(:FamilyName).maybe(:string)
                optional(:GivenName).maybe(:string)
                optional(:MiddleName).maybe(:string)
                optional(:PrimaryPhone).maybe(:hash, Types::Reference)
                optional(:PrimaryEmailAddr).maybe(:hash, Types::Reference)
                optional(:Subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
