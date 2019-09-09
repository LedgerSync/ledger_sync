require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Account::Operations::Find do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank')}

  it do
    instance = described_class.new(resource: account, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
