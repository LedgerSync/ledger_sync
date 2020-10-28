# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  # Account 1 needs to be Liability account
  let(:account1) do
    build(:quickbooks_online_account, ledger_id: '123')
  end

  # Account 2 needs to be different
  let(:account2) do
    build(:quickbooks_online_account, ledger_id: '123')
  end

  let(:vendor) do
    build(:quickbooks_online_vendor, ledger_id: '123')
  end

  let(:department) do
    build(:quickbooks_online_department, ledger_id: '123')
  end

  let(:ledger_class) do
    build(:quickbooks_online_ledger_class, ledger_id: '123')
  end

  let(:line_item_1) do
    build(
      :quickbooks_online_bill_line,
      Amount: 12_345,
      Description: 'Sample Transaction 1',
      AccountBasedExpenseLineDetail: build(
        :quickbooks_online_account_based_expense_line_detail,
        Account: account2,
        Class: ledger_class
      )
    )
  end

  let(:line_item_2) do
    build(
      :quickbooks_online_bill_line,
      Amount: 12_345,
      Description: 'Sample Transaction 2',
      AccountBasedExpenseLineDetail: build(
        :quickbooks_online_account_based_expense_line_detail,
        Account: account2,
        Class: ledger_class
      )
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_bill,
      APAccount: account1,
      Department: department,
      Vendor: vendor,
      Currency: build(:quickbooks_online_currency, Symbol: 'USD', Name: 'United States Dollar'),
      DocNumber: 'Ref123',
      PrivateNote: 'Memo',
      TxnDate: Date.parse('2019-09-01'),
      DueDate: Date.parse('2019-09-01'),
      Line: [
        line_item_1,
        line_item_2
      ]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_bill_create
end
