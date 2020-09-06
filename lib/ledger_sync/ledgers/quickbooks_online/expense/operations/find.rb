# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:Account).hash(Types::Reference)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:Department).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:Line).array(Types::Reference)
                optional(:PrivateNote).maybe(:string)
                optional(:PaymentType).maybe(:string)
                optional(:DocNumber).maybe(:string)
                optional(:TxnDate).filled(:date?)
                optional(:Entity).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
