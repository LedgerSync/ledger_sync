# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :accounting_info,
                    hash_attribute: 'AccountingInfoPrefs'

          attribute :product_and_services,
                    hash_attribute: 'ProductAndServicesPrefs'

          attribute :sales_forms,
                    hash_attribute: 'SalesFormsPrefs'

          attribute :email_messages,
                    hash_attribute: 'EmailMessagesPrefs'

          attribute :vendor_and_purchases,
                    hash_attribute: 'VendorAndPurchasesPrefs'

          attribute :time_tracking,
                    hash_attribute: 'TimeTrackingPrefs'

          attribute :tax,
                    hash_attribute: 'TaxPrefs'

          attribute :currency,
                    hash_attribute: 'CurrencyPrefs'

          attribute :report,
                    hash_attribute: 'ReportPrefs'

          attribute :other,
                    hash_attribute: 'OtherPrefs'
        end
      end
    end
  end
end
