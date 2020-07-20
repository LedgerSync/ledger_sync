# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :AccountingInfoPrefs
          attribute :ProductAndServicesPrefs
          attribute :SalesFormsPrefs
          attribute :EmailMessagesPrefs
          attribute :VendorAndPurchasesPrefs
          attribute :TimeTrackingPrefs
          attribute :TaxPrefs
          attribute :CurrencyPrefs
          attribute :ReportPrefs
          attribute :OtherPrefs
        end
      end
    end
  end
end
