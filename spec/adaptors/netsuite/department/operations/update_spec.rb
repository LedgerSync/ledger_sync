# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Department::Operations::Update do
  include InputHelpers
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create(:department, ledger_id: 7) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_department_find
                    stub_department_update
                  ]
end
