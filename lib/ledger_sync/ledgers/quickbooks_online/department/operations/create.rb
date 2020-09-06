# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:Name).filled(:string)
                required(:Active).filled(:bool?)
                required(:SubDepartment).filled(:bool?)
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
