# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:ARAccount).hash(Types::Reference)
                required(:Currency).filled(:hash, Types::Reference)
                required(:Customer).hash(Types::Reference)
                optional(:DepositToAccount).hash(Types::Reference)
                optional(:ExchangeRate).maybe(:float)
                required(:ledger_id).filled(:string)
                required(:Line).array(Types::Reference)
                optional(:PrivateNote).filled(:string)
                optional(:PaymentRefNum).maybe(:string)
                required(:TotalAmt).filled(:integer)
                optional(:TxnDate).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
