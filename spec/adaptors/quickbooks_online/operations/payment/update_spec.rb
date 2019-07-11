require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Update do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test')}
  let(:payment) { LedgerSync::Payment.new(ledger_id: '123', amount: 150, currency: 'USD', customer: customer)}

  it do
    instance = described_class.new(resource: payment, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
