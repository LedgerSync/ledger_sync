# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    build(
      :quickbooks_online_customer,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:account) do
    build(
      :quickbooks_online_account,
      ledger_id: '123'
    )
  end

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:item) do
    create(
      :quickbooks_online_item,
      ledger_id: '123'
    )
  end

  let(:line_item) do
    build(
      :quickbooks_online_invoice_line,
      ledger_id: nil,
      Amount: 100,
      Description: 'Sample Description',
      SalesItemLineDetail: build(
        :quickbooks_online_sales_item_line_detail,
        Item: item,
        Class: nil
      )
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_invoice,
      ledger_id: nil,
      Customer: customer,
      Currency: currency,
      DepositToAccount: account,
      PrivateNote: 'Memo 1',
      TxnDate: Date.new(2019, 9, 1),
      Line: [
        line_item
      ]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_invoice_create
end
