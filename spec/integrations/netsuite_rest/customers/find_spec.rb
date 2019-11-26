# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :netsuite_rest_helpers

RSpec.describe 'netsuite_rest/customers/find', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include NetSuiteRESTHelpers

  before do
    stub_find_customer
  end

  let(:resource) do
    LedgerSync::Customer.new(customer_resource(ledger_id: 123))
  end

  let(:input) do
    {
      adaptor: netsuite_rest_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Find.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
