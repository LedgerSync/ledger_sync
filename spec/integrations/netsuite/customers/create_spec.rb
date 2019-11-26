# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :netsuite_helpers

RSpec.describe 'netsuite_online/customers/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include NetSuiteHelpers

  # before do
  #   stub_create_customer
  # end

  let(:resource) do
    LedgerSync::Customer.new(customer_resource(ledger_id: 123))
  end

  let(:input) do
    {
      adaptor: netsuite_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
