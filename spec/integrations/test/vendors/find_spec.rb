require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/vendors/find', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:resource) do
    LedgerSync::Vendor.new(vendor_resource({ledger_id: '123'}))
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Vendor::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
