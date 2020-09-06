# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
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
