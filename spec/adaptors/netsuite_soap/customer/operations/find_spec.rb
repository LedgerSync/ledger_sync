# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_soap_helpers

RSpec.describe LedgerSync::Adaptors::NetSuiteSOAP::Customer::Operations::Find, vcr: true do
  include InputHelpers
  include NetSuiteSOAPHelpers

  let(:adaptor) { netsuite_soap_adaptor }
  let(:resource) { LedgerSync::Customer.new(customer_resource(ledger_id: 1837)) }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation'
end
