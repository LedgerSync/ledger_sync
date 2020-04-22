# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      class DashboardURLHelper < LedgerSync::Adaptors::DashboardURLHelper
        def resource_path
          @resource_path = case resource
          when LedgerSync::Account
            "/app/accounting/account/account.nl?id=#{resource.ledger_id}"
          when LedgerSync::Currency
            "/app/common/multicurrency/currency.nl?id=#{resource.ledger_id}"
          when LedgerSync::Customer, LedgerSync::Vendor
            "/app/common/entity/entity.nl?id=#{resource.ledger_id}"
          when LedgerSync::Department
            "/app/common/otherlists/departmenttype.nl?id=#{resource.ledger_id}"
          when LedgerSync::Deposit, LedgerSync::Invoice
            "/app/accounting/transactions/transaction.nl?id=#{resource.ledger_id}"
          end
        end
      end
    end
  end
end
