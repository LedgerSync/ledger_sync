# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class DashboardURLHelper
        PRODUCTION_APP_URL_BASE = 'https://qbo.intuit.com/app'
        SANDBOX_APP_URL_BASE    = 'https://app.sandbox.qbo.intuit.com/app'

        attr_reader :resource,
                    :test

        def initialize(resource:, test:)
          @resource = resource
          @test = test
        end

        def production_url
          @production_url ||= PRODUCTION_APP_URL_BASE + resource_path
        end

        def resource_path
          @resource_path = case resource
          when LedgerSync::Account
            "/register?accountId=#{resource.ledger_id}"
          when LedgerSync::Bill
            "/bill?txnId=#{resource.ledger_id}"
          when LedgerSync::Customer
            "/customerdetail?nameId=#{resource.ledger_id}"
          when LedgerSync::Deposit
            "/deposit?txnId=#{resource.ledger_id}"
          when LedgerSync::Expense
            "/expense?txnId=#{resource.ledger_id}"
          when LedgerSync::JournalEntry
            "/journal?txnId=#{resource.ledger_id}"
          when LedgerSync::LedgerClass
            "/class"
          when LedgerSync::Payment
            "/recvpayment?txnId=#{resource.ledger_id}"
          when LedgerSync::Transfer
            "/transfer?txnId=#{resource.ledger_id}"
          when LedgerSync::Vendor
            "/vendordetail?nameId=#{resource.ledger_id}"
          end
        end

        def sandbox_url
          @sandbox_url ||= SANDBOX_APP_URL_BASE + resource_path
        end

        def url
          return production_url unless test

          sandbox_url
        end
      end
    end
  end
end
