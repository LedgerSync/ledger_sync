require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Vendor::Operations::Upsert do
  include AdaptorHelpers

  let(:vendor1) { LedgerSync::Vendor.new(first_name: 'Test', last_name: 'Tester')}
  let(:vendor2) { LedgerSync::Vendor.new(ledger_id: '123', first_name: 'Test', last_name: 'Tester')}

  it do
    instance = described_class.new(resource: vendor1, adaptor: test_adaptor)
    expect(instance).to be_valid
  end

  it do
    instance = described_class.new(resource: vendor2, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
