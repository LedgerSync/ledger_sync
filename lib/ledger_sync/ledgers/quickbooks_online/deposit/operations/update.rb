# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:DepositToAccount).hash(Types::Reference)
                required(:Currency).filled(:hash, Types::Reference)
                required(:Department).hash(Types::Reference)
                required(:PrivateNote).filled(:string)
                required(:TxnDate).filled(:date?)
                required(:ExchangeRate).maybe(:float)
                required(:Line).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
