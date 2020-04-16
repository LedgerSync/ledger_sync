# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Location::Operations::Create do
  include InputHelpers
  include NetSuiteHelpers

  let(:record) { :location }
  let(:resource) { FactoryBot.create(record) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_for_record
                    stub_create_for_record
                  ]
end
