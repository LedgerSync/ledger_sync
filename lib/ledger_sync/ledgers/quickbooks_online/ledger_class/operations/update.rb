# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:Name).filled(:string)
                required(:Active).filled(:bool?)
                required(:SubClass).filled(:bool?)
                optional(:FullyQualifiedName).maybe(:string)
                optional(:Parent).maybe(:hash, Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
