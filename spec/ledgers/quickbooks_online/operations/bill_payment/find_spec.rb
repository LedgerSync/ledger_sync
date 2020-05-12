# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:vendor) { build(:vendor, ledger_id: '123') }
  let(:account) { build(:account, ledger_id: '123') }
  let(:bill) { build(:bill, ledger_id: '123') }
  let(:department) { build(:department, ledger_id: '123') }
  let(:currency) { build(:currency, name: 'United States Dollar', symbol: 'USD') }

  let(:resource) do
    build(
      :bill_payment,
      ledger_id: '123',

      account: account,
      currency: currency,
      department: department,
      vendor: vendor,

      credit_card_account: account,
      bank_account: nil,

      line_items: []
    )
  end

  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_bill_payment_find
end
