require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Purchase::Operations::Create do
  include AdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(first_name: 'First', last_name: 'Last')}
  let(:purchase) { LedgerSync::Purchase.new(amount: 150, currency: 'USD', vendor: vendor)}

  it do
    instance = described_class.new(resource: purchase, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
