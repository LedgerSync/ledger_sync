# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:Customer).hash(Types::Reference)
                optional(:Deposit).maybe(:integer)
                optional(:DepositToAccount).hash(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:Line).array(Types::Reference)
                optional(:PrivateNote).maybe(:string)
                optional(:TxnDate).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end
