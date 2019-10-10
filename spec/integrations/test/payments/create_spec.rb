require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/payments/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource)
  end

  let(:resource) do
    LedgerSync::Payment.new(payment_resource({customer: customer}))
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Payment::Operations::Create.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
