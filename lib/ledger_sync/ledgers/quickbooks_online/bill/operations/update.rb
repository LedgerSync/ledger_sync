# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:APAccount).hash(Types::Reference)
                optional(:Currency).hash(Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:DueDate).maybe(:date?)
                required(:Line).array(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:Memo).maybe(:string)
                optional(:DocNumber).maybe(:string)
                optional(:TxnDate).maybe(:date?)
                required(:Vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
