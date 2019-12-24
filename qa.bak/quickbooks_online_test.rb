# frozen_string_literal: true

module QA
  class QuickBooksOnlineTest < QA::Test
    def run
      puts 'Testing QuickBooksOnline'

      quickbooks_online_adaptor = LedgerSync.adaptors.qbo.new(
        access_token: config['quickbooks_online']['access_token'],
        client_id: config['quickbooks_online']['client_id'],
        client_secret: config['quickbooks_online']['client_secret'],
        realm_id: config['quickbooks_online']['realm_id'],
        refresh_token: config['quickbooks_online']['refresh_token'],
        test: true
      )

      quickbooks_online_adaptor.refresh!

      account = LedgerSync::Account.new(
        name: "Test Account #{test_run_id}",
        classification: 'asset',
        account_type: 'bank',
        account_sub_type: 'cash_on_hand',
        currency: 'usd',
        description: "Test #{test_run_id} Account description",
        active: true
      )

      result = perform(LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Create.new(
                         adaptor: quickbooks_online_adaptor,
                         resource: account
                       ))

      account = result.resource

      vendor = LedgerSync::Vendor.new(
        email: "test-#{test_run_id}-vendor@example.com",
        first_name: "TestFirst#{test_run_id}",
        last_name: "TestLast#{test_run_id}",
        display_name: "Test #{test_run_id} Display Name"
      )

      result = perform(LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Create.new(
                         adaptor: quickbooks_online_adaptor,
                         resource: vendor
                       ))

      vendor = result.resource

      expense_line_item_1 = LedgerSync::ExpenseLineItem.new(
        account: account,
        amount: 12_345,
        description: "Test #{test_run_id} Line Item 1"
      )

      expense_line_item_2 = LedgerSync::ExpenseLineItem.new(
        account: account,
        amount: 23_456,
        description: "Test #{test_run_id} Line Item 2"
      )

      expense = LedgerSync::Expense.new(
        currency: 'usd',
        memo: 'Testing',
        payment_type: 'cash',
        transaction_date: Date.today,
        exchange_rate: 1.0,
        entity: vendor,
        account: account,
        line_items: [
          expense_line_item_1,
          expense_line_item_2
        ]
      )
      operation = LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create.new(
        adaptor: quickbooks_online_adaptor,
        resource: expense
      )

      result = perform(operation)

      pdb result.success?

      config['quickbooks_online']['access_token'] = quickbooks_online_adaptor.access_token
      config['quickbooks_online']['refresh_token'] = quickbooks_online_adaptor.refresh_token
      config
    end
  end
end
