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
                required(:AccountingInfoPrefs).maybe(:hash)
                required(:ProductAndServicesPrefs).maybe(:hash)
                required(:SalesFormsPrefs).maybe(:hash)
                required(:EmailMessagesPrefs).maybe(:hash)
                required(:VendorAndPurchasesPrefs).maybe(:hash)
                required(:TimeTrackingPrefs).maybe(:hash)
                required(:TaxPrefs).maybe(:hash)
                required(:CurrencyPrefs).maybe(:hash)
                required(:ReportPrefs).maybe(:hash)
                required(:OtherPrefs).maybe(:hash)
              end
            end
          end
        end
      end
    end
  end
end
