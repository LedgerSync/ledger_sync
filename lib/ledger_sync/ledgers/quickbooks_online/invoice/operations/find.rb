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
                optional(:account).hash(Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                optional(:customer).hash(Types::Reference)
                optional(:deposit).maybe(:integer)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:transaction_date).maybe(:date?)
              end
            end
          end
        end
      end
    end
  end
end
