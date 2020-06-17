# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:currency) do
    create(
      :quickbooks_online_currency,
      name: 'United States Dollar',
      symbol: 'USD'
    )
  end
  let(:from_account) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(
      ledger_id: '123',
      name: 'Test 1',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand'
    )
  end
  let(:to_account) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(
      ledger_id: '123',
      name: 'Test 2',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand'
    )
  end
  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Transfer.new(
      ledger_id: '123',
      from_account: from_account,
      to_account: to_account,
      amount: 0,
      currency: currency,
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1)
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_transfer
end
