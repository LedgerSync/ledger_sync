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
                required(:ledger_id).value(:nil)
                required(:AccountSubType).filled(:string)
                required(:AccountType).filled(:string)
                required(:AcctNum).maybe(:string)
                required(:Active).maybe(:bool)
                required(:Classification).filled(:string)
                required(:Currency).maybe(:hash, Types::Reference)
                required(:Description).maybe(:string)
                required(:Name).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
