# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:from_account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test 1', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:to_account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test 2', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:resource) { LedgerSync::Transfer.new(ledger_id: '123', from_account: from_account, to_account: to_account, amount: 0, currency: FactoryBot.create(:currency), memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1))}
  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_transfer
end
