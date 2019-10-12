require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Transfer::Operations::Create do
  include AdaptorHelpers

  let(:from_account) { LedgerSync::Account.new(name: 'Test 1', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:to_account) { LedgerSync::Account.new(name: 'Test 2', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:transfer) { LedgerSync::Transfer.new(from_account: from_account, to_account: to_account, amount: 0, currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1))}

  it do
    instance = described_class.new(resource: transfer, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
