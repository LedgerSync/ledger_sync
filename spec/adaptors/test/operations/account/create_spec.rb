require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Account::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', classification: 'asset', account_type: 'bank', account_sub_type: 'cash_on_hand')}

  it do
    instance = described_class.new(resource: account, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
