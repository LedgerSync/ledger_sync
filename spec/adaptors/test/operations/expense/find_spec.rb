require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Expense::Operations::Find do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:vendor) { LedgerSync::Vendor.new(ledger_id: '123', first_name: 'Test', last_name: 'Testing')}
  let(:expense) { LedgerSync::Expense.new(ledger_id: '123', account: account, vendor: vendor, amount: 0, currency: 'USD', memo: 'Memo 1', payment_type: 'cash', transaction_date: Date.new(2019, 9, 1), line_items: [])}


  it do
    instance = described_class.new(resource: expense, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
