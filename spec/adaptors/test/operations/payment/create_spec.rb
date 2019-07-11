require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Payment::Operations::Create do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(name: 'Test')}
  let(:payment) { LedgerSync::Payment.new(amount: 150, currency: 'USD', customer: customer)}

  it do
    instance = described_class.new(resource: payment, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
