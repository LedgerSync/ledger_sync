# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Preferences
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'AccountingInfoPrefs',
                    resource_attribute: :accounting_info

          attribute ledger_attribute: 'ProductAndServicesPrefs',
                    resource_attribute: :product_and_services

          attribute ledger_attribute: 'SalesFormsPrefs',
                    resource_attribute: :sales_forms

          attribute ledger_attribute: 'EmailMessagesPrefs',
                    resource_attribute: :email_messages

          attribute ledger_attribute: 'VendorAndPurchasesPrefs',
                    resource_attribute: :vendor_and_purchases

          attribute ledger_attribute: 'TimeTrackingPrefs',
                    resource_attribute: :time_tracking

          attribute ledger_attribute: 'TaxPrefs',
                    resource_attribute: :tax

          attribute ledger_attribute: 'CurrencyPrefs',
                    resource_attribute: :currency

          attribute ledger_attribute: 'ReportPrefs',
                    resource_attribute: :report

          attribute ledger_attribute: 'OtherPrefs',
                    resource_attribute: :other

          def self.inferred_resource_class
            LedgerSync::Adaptors::QuickBooksOnline::Preferences
          end
        end
      end
    end
  end
end
