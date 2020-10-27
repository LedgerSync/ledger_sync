# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:Name).maybe(:string)
                optional(:Active).maybe(:bool?)
                optional(:SubClass).maybe(:bool?)
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
