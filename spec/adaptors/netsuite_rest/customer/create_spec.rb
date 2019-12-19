# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_rest_helpers

RSpec.describe LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Create do
  include InputHelpers
  include NetSuiteRESTHelpers

  let(:resource) { LedgerSync::Customer.new(customer_resource) }
  let(:adaptor) { netsuite_rest_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_customer_find
                    stub_customer_create
                  ]
end
