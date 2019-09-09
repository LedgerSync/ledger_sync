require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Upsert do
  include AdaptorHelpers

  let(:account1) { LedgerSync::Account.new(name: 'Test', account_type: 'bank')}
  let(:account2) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank')}

  it do
    instance = described_class.new(resource: account1, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end

  it do
    instance = described_class.new(resource: account2, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
