require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Account::Operations::Upsert do
  include AdaptorHelpers

  let(:account1) { LedgerSync::Account.new(name: 'Test', account_type: 'cash_on_hand')}
  let(:account2) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'cash_on_hand')}

  it do
    instance = described_class.new(resource: account1, adaptor: test_adaptor)
    expect(instance).to be_valid
  end

  it do
    instance = described_class.new(resource: account2, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
