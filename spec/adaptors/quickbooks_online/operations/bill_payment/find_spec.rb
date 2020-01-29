# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::BillPayment::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:vendor) do
    LedgerSync::Vendor.new(ledger_id: '123')
  end

  let(:account) do
    LedgerSync::Account.new(ledger_id: '123')
  end

  let(:bill) do
    LedgerSync::Bill.new(ledger_id: '123')
  end

  let(:department) do
    LedgerSync::Department.new(ledger_id: '123')
  end

  let(:currency) do
    LedgerSync::Currency.new(
      name: 'United States Dollar',
      symbol: 'USD'
    )
  end

  let(:resource) do
    LedgerSync::BillPayment.new(
      ledger_id: '123',

      account: account,
      currency: currency,
      department: department,
      vendor: vendor,

      line_items: []
    )
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_bill_payment_find
end
