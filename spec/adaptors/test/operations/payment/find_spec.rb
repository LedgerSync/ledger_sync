require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Payment::Operations::Find do
  include TestAdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test')}
  let(:payment) { LedgerSync::Payment.new(ledger_id: '123', amount: 150, currency: 'USD', customer: customer)}

  it do
    instance = described_class.new(resource: payment, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
