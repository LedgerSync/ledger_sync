require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Vendor::Operations::Create do
  include TestAdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(display_name: 'Test Tester')}

  it do
    instance = described_class.new(resource: vendor, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
