# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'AccountingInfoPrefs',
                    resource_attribute: :accounting_info

          attribute 'ProductAndServicesPrefs',
                    resource_attribute: :product_and_services

          attribute 'SalesFormsPrefs',
                    resource_attribute: :sales_forms

          attribute 'EmailMessagesPrefs',
                    resource_attribute: :email_messages

          attribute 'VendorAndPurchasesPrefs',
                    resource_attribute: :vendor_and_purchases

          attribute 'TimeTrackingPrefs',
                    resource_attribute: :time_tracking

          attribute 'TaxPrefs',
                    resource_attribute: :tax

          attribute 'CurrencyPrefs',
                    resource_attribute: :currency

          attribute 'ReportPrefs',
                    resource_attribute: :report

          attribute 'OtherPrefs',
                    resource_attribute: :other
        end
      end
    end
  end
end
