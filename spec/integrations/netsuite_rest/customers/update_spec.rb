# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :netsuite_rest_helpers

RSpec.describe 'netsuite_rest/customers/update', type: :feature do
  include InputHelpers
  include NetSuiteRESTHelpers

  let(:resource) do
    LedgerSync::Customer.new(customer_resource(ledger_id: '1137'))
  end

  let(:input) do
    {
      adaptor: netsuite_rest_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Update.new(**input).perform }

    it do
      stub_customer_find
      stub_customer_update
      expect(subject).to be_a(LedgerSync::OperationResult::Success)
    end
  end
end
