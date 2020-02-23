# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module BillPayment
        module Operations
          class Update < Operation::FullUpdate
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                optional(:account).hash(Types::Reference)
                required(:amount).filled(:integer)
                optional(:bank_account).hash(Types::Reference)
                optional(:credit_card_account).hash(Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
                optional(:exchange_rate).maybe(:float)
                required(:ledger_id).filled(:string)
                required(:line_items).array(Types::Reference)
                optional(:memo).filled(:string)
                required(:payment_type).filled(:string)
                optional(:reference_number).maybe(:string)
                optional(:transaction_date).filled(:date?)
                required(:vendor).hash(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
