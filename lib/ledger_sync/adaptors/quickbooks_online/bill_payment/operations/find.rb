# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module BillPayment
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                optional(:amount).maybe(:integer)
                optional(:bank_account).maybe(Types::Reference)
                optional(:credit_card_account).maybe(Types::Reference)
                required(:currency).maybe(:hash, Types::Reference)
                optional(:department).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                optional(:line_items).array(Types::Reference)
                optional(:memo).maybe(:string)
                optional(:payment_type).maybe(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).maybe(:date?)
                optional(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
