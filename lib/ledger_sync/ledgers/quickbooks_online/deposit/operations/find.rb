# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:DepositToAccount).hash(Types::Reference)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:Department).hash(Types::Reference)
                optional(:PrivateNote).maybe(:string)
                optional(:TxnDate).filled(:date?)
                optional(:ExchangeRate).maybe(:float)
                optional(:Line).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
