# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        module Operations
          class Create < QuickBooksOnline::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:Account).hash(Types::Reference)
                optional(:Currency).hash(Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                optional(:ledger_id).value(:nil)
                required(:Line).array(Types::Reference)
                optional(:PrivateNote).filled(:string)
                required(:PaymentType).filled(:string)
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
