require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Deposit::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:deposit) { LedgerSync::Deposit.new(account: account, currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), line_items: [])}

  it do
    instance = described_class.new(resource: deposit, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
