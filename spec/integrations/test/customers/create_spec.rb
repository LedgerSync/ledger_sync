require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/customers/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:resource) do
    LedgerSync::Customer.new(customer_resource)
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Customer::Operations::Create.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
