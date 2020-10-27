# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:Currency).filled(:hash, Types::Reference)
                required(:Customer).hash(Types::Reference)
                optional(:Deposit).maybe(:integer)
                optional(:DepositToAccount).hash(Types::Reference)
                required(:ledger_id).filled(:string)
                required(:Line).array(Types::Reference)
                optional(:PrivateNote).filled(:string)
                optional(:TxnDate).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
