require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Update do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test')}

  it do
    instance = described_class.new(resource: customer, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
