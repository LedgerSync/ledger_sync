# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Customer::Operations::Create, type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include NetSuiteHelpers

  before { stub_customer_create }

  let(:resource) do
    LedgerSync::Customer.new(customer_resource)
  end

  let(:input) do
    {
      adaptor: netsuite_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { described_class.new(**input).perform }

    it { expect(subject).to be_valid }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
    it { expect(subject.resource.ledger_id).to eq('123') }
  end
end
