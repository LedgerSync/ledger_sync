require 'spec_helper'

support :input_helpers
support :test_adaptor_helpers

RSpec.describe 'test/payments/find', type: :feature do
  include InputHelpers
  include TestAdaptorHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource)
  end

  let(:resource) do
    LedgerSync::Payment.new(payment_resource({ledger_id: '123', customer: customer}))
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Payment::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
