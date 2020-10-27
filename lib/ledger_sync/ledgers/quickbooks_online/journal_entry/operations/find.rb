# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:Currency).maybe(:hash, Types::Reference)
                optional(:DocNumber).maybe(:string)
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
