# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:ARAccount).hash(Types::Reference)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:Customer).hash(Types::Reference)
                optional(:DepositToAccount).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:Line).array(Types::Reference)
                optional(:PrivateNote).maybe(:string)
                optional(:PaymentRefNum).maybe(:string)
                optional(:TotalAmt).maybe(:integer)
                optional(:TxnDate).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end
