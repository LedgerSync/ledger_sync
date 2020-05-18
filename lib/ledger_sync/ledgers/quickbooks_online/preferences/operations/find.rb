# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:accounting_info).maybe(:hash)
                required(:product_and_services).maybe(:hash)
                required(:sales_forms).maybe(:hash)
                required(:email_messages).maybe(:hash)
                required(:vendor_and_purchases).maybe(:hash)
                required(:time_tracking).maybe(:hash)
                required(:tax).maybe(:hash)
                required(:currency).maybe(:hash)
                required(:report).maybe(:hash)
                required(:other).maybe(:hash)
              end
            end
          end
        end
      end
    end
  end
end
