# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::BillPayment::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:vendor) { build(:vendor, ledger_id: '123') }
  let(:account) { build(:account, ledger_id: '123') }
  let(:bill) { build(:bill, ledger_id: '123') }
  let(:department) { build(:department, ledger_id: '123') }
  let(:currency) { build(:currency, name: 'United States Dollar', symbol: 'USD') }

  let(:line_item) { build(:bill_payment_line_item, amount: 100, ledger_transactions: [bill]) }

  let(:resource) do
    build(
      :bill_payment,
      ledger_id: '123',
      amount: 100,
      memo: 'Note',
      transaction_date: Date.parse('2019-09-01'),
      exchange_rate: 1.0,
      reference_number: 'Ref123',

      account: account,
      currency: currency,
      department: department,
      vendor: vendor,

      line_items: [line_item]
    )
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_bill_payment_find
                    stub_bill_payment_update
                  ]
end
