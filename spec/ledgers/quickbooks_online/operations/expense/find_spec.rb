# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand') }
  let(:vendor) { LedgerSync::Vendor.new(ledger_id: '123', first_name: 'Test', last_name: 'Testing') }
  let(:department) { LedgerSync::Department.new(ledger_id: '123') }
  let(:resource) { LedgerSync::Expense.new(ledger_id: '123', account: account, department: department, entity: vendor, currency: FactoryBot.create(:currency), memo: 'Memo 1', payment_type: 'cash', transaction_date: Date.new(2019, 9, 1), line_items: []) }
  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_expense
end
