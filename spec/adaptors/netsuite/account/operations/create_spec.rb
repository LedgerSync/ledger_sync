# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Account::Operations::Create do
  include InputHelpers
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create(:account) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: %i[
    stub_account_create
    stub_account_find
  ]
end
