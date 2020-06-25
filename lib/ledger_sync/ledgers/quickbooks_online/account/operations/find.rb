# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:AccountType).maybe(:string)
                required(:AccountSubType).maybe(:string)
                required(:AcctNum).maybe(:string)
                required(:Active).maybe(:bool)
                required(:Classification).maybe(:string)
                required(:Currency).maybe(:hash, Types::Reference)
                required(:Description).maybe(:string)
                required(:Name).maybe(:string)
              end
            end
          end
        end
      end
    end
  end
end
