# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_rest_helpers

RSpec.describe LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Find do
  include InputHelpers
  include NetSuiteRESTHelpers

  let(:resource) { LedgerSync::Customer.new(customer_resource(ledger_id: 1137)) }
  let(:adaptor) { netsuite_rest_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_customer_find
end
