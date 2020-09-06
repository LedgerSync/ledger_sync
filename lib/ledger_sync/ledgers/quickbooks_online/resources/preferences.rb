# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences < QuickBooksOnline::Resource
        attribute :AccountingInfoPrefs, type: Type::Hash
        attribute :ProductAndServicesPrefs, type: Type::Hash
        attribute :SalesFormsPrefs, type: Type::Hash
        attribute :EmailMessagesPrefs, type: Type::Hash
        attribute :VendorAndPurchasesPrefs, type: Type::Hash
        attribute :TimeTrackingPrefs, type: Type::Hash
        attribute :TaxPrefs, type: Type::Hash
        attribute :CurrencyPrefs, type: Type::Hash
        attribute :ReportPrefs, type: Type::Hash
        attribute :OtherPrefs, type: Type::Hash

        def name
          'Preference'
        end
      end
    end
  end
end
