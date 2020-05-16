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
