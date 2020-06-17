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
                required(:name).maybe(:string)
                required(:classification).maybe(:string)
                required(:account_type).maybe(:string)
                required(:account_sub_type).maybe(:string)
                required(:number).maybe(:string)
                required(:currency).maybe(:hash, Types::Reference)
                required(:description).maybe(:string)
                required(:active).maybe(:bool)
              end
            end
          end
        end
      end
    end
  end
end
