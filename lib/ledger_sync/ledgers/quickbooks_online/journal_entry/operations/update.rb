# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:Currency).hash(Types::Reference)
                optional(:DocNumber).filled(:string)
                required(:ledger_id).filled(:string)
                optional(:Line).array(Types::Reference)
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
