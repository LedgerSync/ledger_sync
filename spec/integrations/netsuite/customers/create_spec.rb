# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :netsuite_helpers
support :operation_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Customer::Operations::Create, type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include NetSuiteHelpers
  include OperationHelpers

  let(:resource) do
    LedgerSync::Customer.new(
      customer_resource.merge(
        subsidiary: LedgerSync::Subsidiary.new(
          ledger_id: 1003
        )
      )
    )
  end

  let(:initialized_operation) { described_class.new(**input) }

  let(:input) do
    {
      adaptor: netsuite_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { described_class.new(**input).perform }

    it { expect_valid(operation: initialized_operation) }
    it do
      VCR.use_cassette('netsuite/customers/create') do
        expect(subject).to be_a(LedgerSync::OperationResult::Success)
        expect(subject.resource.ledger_id).to eq('123')
      end
    end
  end
end
