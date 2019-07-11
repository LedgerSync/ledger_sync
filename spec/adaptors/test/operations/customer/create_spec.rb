require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Customer::Operations::Create do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(name: 'Test')}

  it do
    instance = described_class.new(resource: customer, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
