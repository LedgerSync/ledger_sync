# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:Account).hash(Types::Reference)
                optional(:Currency).hash(Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).filled(:string)
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
