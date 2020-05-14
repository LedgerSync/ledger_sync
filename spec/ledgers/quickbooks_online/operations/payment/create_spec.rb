# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Payment::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:customer) do
    create(
      :quickbooks_online_customer,
      external_id: :ext_id,
      ledger_id: 123,
      PrimaryEmailAddr: create(
        :quickbooks_online_primary_email_addr,
        Address: 'test@example.com'
      ),
      PrimaryPhone: nil,
      DisplayName: 'Sample Customer'
    )
  end

  let(:account) do
    create(
      :quickbooks_online_account,
      ledger_id: 123
    )
  end

  let(:item) do
    create(
      :quickbooks_online_item,
      ledger_id: 123
    )
  end

  let(:invoice_line_item) do
    create(
      :quickbooks_online_invoice_sales_line_item,
      ledger_id: nil,
      ledger_class: create(
        :quickbooks_online_ledger_class,
        ledger_id: nil
      ),
      item: item,
      amount: 100,
      description: 'Sample Description'
    )
  end

  let(:currency) do
    create(
      :quickbooks_online_currency,
      name: 'United States Dollar',
      symbol: 'USD'
    )
  end

  let(:invoice) do
    create(
      :quickbooks_online_invoice,
      ledger_id: 123,
      customer: customer,
      currency: currency,
      account: account,
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      line_items: [invoice_line_item]
    )
  end

  let(:line_item) do
    create(
      :quickbooks_online_payment_line_item,
      ledger_id: nil,
      amount: 100,
      ledger_transactions: [invoice]
    )
  end

  let(:resource) do
    create(
      :quickbooks_online_payment,
      ledger_id: nil,
      exchange_rate: 1.0,
      reference_number: 'Ref123',
      memo: 'Memo',
      amount: 12_345,
      transaction_date: Date.new(2019, 9, 1),
      currency: currency,
      customer: customer,
      account: account,
      deposit_account: account,
      line_items: [line_item]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_payment
end
