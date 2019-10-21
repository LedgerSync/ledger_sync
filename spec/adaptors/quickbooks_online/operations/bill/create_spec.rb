require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Bill::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:vendor) { LedgerSync::Vendor.new(first_name: 'Test', last_name: 'Testing')}
  let(:bill) { LedgerSync::Bill.new(account: account, vendor: vendor, reference_number: 'Ref123', currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), due_date: Date.new(2019, 9, 1), line_items: [])}

  it do
    instance = described_class.new(resource: bill, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
