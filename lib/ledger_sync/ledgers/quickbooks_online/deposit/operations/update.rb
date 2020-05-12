# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Deposit
        module Operations
          class Update < QuickBooksOnline::Operation::FullUpdate
            class Contract < LedgerSync::Ledgers::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:department).hash(Types::Reference)
                required(:memo).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
              end
            end
          end
        end
      end
    end
  end
end
