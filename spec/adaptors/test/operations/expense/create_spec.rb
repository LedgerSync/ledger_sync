require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Expense::Operations::Create do
  include TestAdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:vendor) { LedgerSync::Vendor.new(first_name: 'Test', last_name: 'Testing')}
  let(:expense) { LedgerSync::Expense.new(account: account, entity: vendor, reference_number: 'Ref123', currency: FactoryBot.create(:currency), memo: 'Memo 1', payment_type: 'cash', transaction_date: Date.new(2019, 9, 1), line_items: [])}

  it do
    instance = described_class.new(resource: expense, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
