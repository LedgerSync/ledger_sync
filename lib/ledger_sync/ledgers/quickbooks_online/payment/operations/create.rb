# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:hash, Types::Reference)
                required(:customer).hash(Types::Reference)
                optional(:deposit_account).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).value(:nil)
                required(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).filled(:date?)
              end
            end
          end
        end
      end
    end
  end
end
