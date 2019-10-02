require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Vendor::Operations::Find do
  include AdaptorHelpers

  let(:vendor) { LedgerSync::Vendor.new(ledger_id: '123', first_name: 'Test', last_name: 'Tester')}

  it do
    instance = described_class.new(resource: vendor, adaptor: test_adaptor)
    expect(instance).to be_valid
  end
end
