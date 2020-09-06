# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:FromAccount).hash(Types::Reference)
                optional(:ToAccount).hash(Types::Reference)
                optional(:Amount).maybe(:integer)
                optional(:Currency).maybe(:hash, Types::Reference)
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
