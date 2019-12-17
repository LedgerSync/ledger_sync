require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Vendor::Operations::Update do
  include TestAdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(ledger_id: '123', display_name: 'Test Tester')}

  it do
    instance = described_class.new(resource: vendor, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
