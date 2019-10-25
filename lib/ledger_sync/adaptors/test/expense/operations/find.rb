# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:account).hash(Types::Reference)
                required(:entity).hash(Types::Reference)
                required(:currency).maybe(:string)
                required(:memo).maybe(:string)
                required(:payment_type).maybe(:string)
                required(:transaction_date).maybe(:date?)
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
