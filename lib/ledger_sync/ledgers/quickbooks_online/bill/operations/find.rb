# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        module Operations
          class Find < QuickBooksOnline::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:APAccount).hash(Types::Reference)
                required(:Currency).maybe(:hash, Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:DueDate).maybe(:date?)
                optional(:Line).array(Types::Reference)
                required(:ledger_id).filled(:string)
                optional(:PrivateNote).maybe(:string)
                optional(:DocNumber).maybe(:string)
                optional(:TxnDate).maybe(:date?)
                optional(:Vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
