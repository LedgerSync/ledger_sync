require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(name: 'Test') }

  it do
    instance = described_class.new(resource: customer, adaptor: quickbooks_adaptor)
    instance.valid?
    expect(instance).to be_valid
  end
end
