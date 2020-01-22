# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Deposit::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:department) { LedgerSync::Department.new(ledger_id: '123') }
  let(:resource) { LedgerSync::Deposit.new(ledger_id: '123', account: account, department: department, currency: FactoryBot.create(:currency, :without_test_run_id, name: 'United States Dollars', symbol: 'USD'), memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), line_items: [])}
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_deposit
end
