# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:FromAccount).hash(Types::Reference)
                required(:ToAccount).hash(Types::Reference)
                required(:Amount).filled(:integer)
                required(:Currency).filled(:hash, Types::Reference)
                required(:PrivateNote).filled(:string)
                required(:TxnDate).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
