# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:from_account).hash(Types::Reference)
                required(:to_account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:hash, Types::Reference)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
