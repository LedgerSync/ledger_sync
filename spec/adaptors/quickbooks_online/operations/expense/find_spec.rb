require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Find do
  include AdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(ledger_id: '123', first_name: 'First', last_name: 'Last')}
  let(:expense) { LedgerSync::Expense.new(ledger_id: '123', vendor: vendor, amount: 0, currency: 'USD', memo: 'Memo 1', payment_type: 'cash', transaction_date: '2019-09-01', transactions: [])}

  it do
    instance = described_class.new(resource: expense, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
