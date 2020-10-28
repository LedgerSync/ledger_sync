# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    build(
      :quickbooks_online_account,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:entity) do
    build(
      :quickbooks_online_vendor,
      external_id: :ext_id,
      ledger_id: '123',
      DisplayName: 'Sample Vendor'
    )
  end

  let(:department) do
    build(
      :quickbooks_online_department,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:ledger_class) do
    build(
      :quickbooks_online_ledger_class,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:line_item_1) do
    build(
      :quickbooks_online_expense_line,
      Amount: 12_345,
      Description: 'Sample Transaction 1',
      AccountBasedExpenseLineDetail: build(
        :quickbooks_online_account_based_expense_line_detail,
        Account: account,
        Class: ledger_class
      )
    )
  end

  let(:line_item_2) do
    build(
      :quickbooks_online_expense_line,
      Amount: 12_345,
      Description: 'Sample Transaction 2',
      AccountBasedExpenseLineDetail: build(
        :quickbooks_online_account_based_expense_line_detail,
        Account: account,
        Class: ledger_class
      )
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_expense,
      ledger_id: nil,
      DocNumber: 'Ref123',
      Currency: build(
        :quickbooks_online_currency,
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      PrivateNote: 'Memo',
      PaymentType: 'cash',
      ExchangeRate: 1.0,
      TxnDate: Date.parse('2019-09-01'),
      Account: account,
      Department: department,
      Entity: entity,
      Line: [
        line_item_1,
        line_item_2
      ]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_expense_create
end
