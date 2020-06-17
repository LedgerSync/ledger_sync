# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DashboardURLHelper < LedgerSync::Ledgers::DashboardURLHelper
        def resource_path # rubocop:disable Metrics/CyclomaticComplexity
          @resource_path = case resource
                           when QuickBooksOnline::Account
                             "/register?accountId=#{resource.ledger_id}"
                           when QuickBooksOnline::Bill
                             "/bill?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::Customer
                             "/customerdetail?nameId=#{resource.ledger_id}"
                           when QuickBooksOnline::Deposit
                             "/deposit?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::Expense
                             "/expense?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::JournalEntry
                             "/journal?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::LedgerClass
                             '/class'
                           when QuickBooksOnline::Payment
                             "/recvpayment?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::Transfer
                             "/transfer?txnId=#{resource.ledger_id}"
                           when QuickBooksOnline::Vendor
                             "/vendordetail?nameId=#{resource.ledger_id}"
                           end
        end
      end
    end
  end
end
