# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Preferences
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
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

            def self.inferred_resource_class
              Preferences
            end

            def self.inferred_ledger_serializer_class
              Preferences::LedgerSerializer
            end
          end
        end
      end
    end
  end
end
