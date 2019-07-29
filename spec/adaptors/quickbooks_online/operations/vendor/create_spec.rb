require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Create do
  include AdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(first_name: 'First', last_name: 'Last')}

  it do
    instance = described_class.new(resource: vendor, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
