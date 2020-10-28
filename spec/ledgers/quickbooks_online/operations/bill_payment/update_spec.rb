# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:vendor) do
    build(:quickbooks_online_vendor, ledger_id: '123')
  end

  let(:account) do
    build(:quickbooks_online_account, ledger_id: '123')
  end

  let(:bill) do
    build(:quickbooks_online_bill, ledger_id: '123')
  end

  let(:department) do
    build(:quickbooks_online_department, ledger_id: '123')
  end

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:line) do
    build(
      :quickbooks_online_bill_payment_line,
      Amount: 100,
      ledger_id: nil,
      LinkedTxn: [bill]
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_bill_payment,
      ledger_id: '123',
      TotalAmt: 100,
      PrivateNote: 'Note',
      TxnDate: Date.parse('2019-09-01'),
      ExchangeRate: 1.0,
      DocNumber: 'Ref123',
      PayType: :credit_card,

      APAccount: account,
      Currency: currency,
      Department: department,
      Vendor: vendor,

      CreditCardPayment: build(:quickbooks_online_credit_card_payment, CCAccount: account),
      CheckPayment: nil,

      Line: [line]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: %i[
    stub_bill_payment_find
    stub_bill_payment_update
  ]
end
