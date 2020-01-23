# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:account).hash(Types::Reference)
                required(:entity).hash(Types::Reference)
                required(:currency).filled(:hash, Types::Reference)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
                required(:reference_number).filled(:string)
              end
            end
          end
        end
      end
    end
  end
end
