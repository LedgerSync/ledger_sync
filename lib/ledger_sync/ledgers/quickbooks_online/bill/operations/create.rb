# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:APAccount).hash(Types::Reference)
                optional(:Currency).hash(Types::Reference)
                required(:Department).hash(Types::Reference)
                optional(:DueDate).maybe(:date?)
                optional(:ledger_id).value(:nil)
                required(:Line).array(Types::Reference)
                optional(:PrivateNote).maybe(:string)
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
