# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      class DashboardURLHelper
        attr_reader :resource,
                    :account_id

        def initialize(resource:, account_id:)
          @resource = resource
          @account_id = account_id
        end

        def base_url
          "https://#{@account_id}.app.netsuite.com"
        end

        def url
          base_url + resource_path
        end

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
