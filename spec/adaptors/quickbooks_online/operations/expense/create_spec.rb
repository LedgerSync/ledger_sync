require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:vendor) { LedgerSync::Vendor.new(first_name: 'Test', last_name: 'Testing')}
  let(:expense) { LedgerSync::Expense.new(account: account, vendor: vendor, amount: 0, currency: 'USD', memo: 'Memo 1', payment_type: 'cash', transaction_date: Date.new(2019, 9, 1), line_items: [])}

  it do
    instance = described_class.new(resource: expense, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end

  context '#build' do # Todo: Remove in future PR.
    subject do
      op = described_class.new(
        adaptor: quickbooks_adaptor,
        resource: expense
      )
      op.prepare
      op
    end
    it { expect(subject.operations.count).to eq(3) }
  end
end
