# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Payment::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    build(
      :quickbooks_online_customer,
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

  let(:invoice) do
    build(
      :quickbooks_online_invoice,
      ledger_id: '123'
    )
  end

  let(:line_item) do
    build(
      :quickbooks_online_payment_line,
      ledger_id: nil,
      Amount: 100,
      LinkedTxn: [invoice]
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_payment,
      ledger_id: '123',
      ExchangeRate: 1.0,
      PaymentRefNum: 'Ref123',
      PrivateNote: 'Memo',
      TotalAmt: 12_345,
      TxnDate: Date.new(2019, 9, 1),
      Currency: currency,
      Customer: customer,
      ARAccount: account,
      DepositToAccount: account,
      Line: [line_item]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_payment_find
                    stub_payment_update
                  ]
end
