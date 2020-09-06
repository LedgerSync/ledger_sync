# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:APAccount).hash(Types::Reference)
                required(:TotalAmt).filled(:integer)
                optional(:CheckPayment).maybe(Types::Reference)
                optional(:CreditCardPayment).maybe(Types::Reference)
                required(:Currency).filled(:hash, Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).value(:nil)
                required(:Line).array(Types::Reference)
                optional(:PrivateNote).filled(:string)
                required(:PayType).filled(:string)
                optional(:DocNumber).maybe(:string)
                optional(:TxnDate).filled(:date?)
                required(:Vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
