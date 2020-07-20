# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:Currency).hash(Types::Reference)
                optional(:DocNumber).filled(:string)
                required(:ledger_id).value(:nil)
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
