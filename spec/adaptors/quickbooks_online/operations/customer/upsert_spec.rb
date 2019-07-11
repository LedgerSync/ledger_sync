require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Upsert do
  include AdaptorHelpers

  let(:customer1) { LedgerSync::Customer.new(name: 'Test')}
  let(:customer2) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test')}

  it do
    instance = described_class.new(resource: customer1, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end

  it do
    instance = described_class.new(resource: customer2, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
