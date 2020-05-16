# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:PrimaryEmailAddr).maybe(:hash, Types::Reference)
                optional(:DisplayName).filled(:string)
                optional(:firstName).maybe(:string)
                optional(:lastName).maybe(:string)
                required(:PrimaryPhone).maybe(:hash, Types::Reference)
                required(:subsidiary).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
