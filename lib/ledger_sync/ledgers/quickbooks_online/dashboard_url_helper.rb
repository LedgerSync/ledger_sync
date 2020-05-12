# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DashboardURLHelper < LedgerSync::Ledgers::DashboardURLHelper
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
      end
    end
  end
end
