# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:account_sub_type).filled(:string)
                required(:account_type).filled(:string)
                required(:active).maybe(:bool)
                required(:classification).filled(:string)
                required(:currency).maybe(:hash, Types::Reference)
                required(:description).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:name).filled(:string)
                required(:number).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
