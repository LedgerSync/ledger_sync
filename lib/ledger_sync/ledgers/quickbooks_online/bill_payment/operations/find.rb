# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:APAccount).hash(Types::Reference)
                optional(:TotalAmt).maybe(:integer)
                optional(:CheckPayment).maybe(Types::Reference)
                optional(:CreditCardPayment).maybe(Types::Reference)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:Department).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:Line).array(Types::Reference)
                optional(:PrivateNote).maybe(:string)
                optional(:PayType).maybe(:string)
                optional(:DocNumber).maybe(:string)
                optional(:TxnDate).maybe(:date?)
                optional(:Vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
