# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:vendor) { build(:quickbooks_online_vendor, ledger_id: '123') }
  let(:account) { build(:quickbooks_online_account, ledger_id: '123') }
  let(:bill) { build(:quickbooks_online_bill, ledger_id: '123') }
  let(:department) { build(:quickbooks_online_department, ledger_id: '123') }
  let(:currency) { build(:quickbooks_online_currency, name: 'United States Dollar', symbol: 'USD') }

  let(:line_item) do
    build(:quickbooks_online_bill_payment_line_item, amount: 100, ledger_id: nil, ledger_transactions: [bill])
  end

  let(:resource) do
    build(
      :quickbooks_online_bill_payment,
      ledger_id: '123',
      memo: 'Note',
      transaction_date: Date.parse('2019-09-01'),
      exchange_rate: 1.0,
      reference_number: 'Ref123',
      payment_type: :credit_card,
      amount: line_item.amount,

      account: account,
      currency: currency,
      department: department,
      vendor: vendor,

      credit_card_account: account,
      bank_account: nil,

      line_items: [line_item]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: %i[
    stub_bill_payment_find
    stub_bill_payment_update
  ]
end
