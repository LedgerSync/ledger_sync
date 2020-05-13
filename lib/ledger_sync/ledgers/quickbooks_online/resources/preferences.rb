# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Preferences < QuickBooksOnline::Resource
        attribute :accounting_info, type: Type::Hash
        attribute :product_and_services, type: Type::Hash
        attribute :sales_forms, type: Type::Hash
        attribute :email_messages, type: Type::Hash
        attribute :vendor_and_purchases, type: Type::Hash
        attribute :time_tracking, type: Type::Hash
        attribute :tax, type: Type::Hash
        attribute :currency, type: Type::Hash
        attribute :report, type: Type::Hash
        attribute :other, type: Type::Hash

        def name
          'Preference'
        end
      end
    end
  end
end
