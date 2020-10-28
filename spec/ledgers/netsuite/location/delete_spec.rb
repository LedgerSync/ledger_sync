# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Location::Operations::Delete do
  include InputHelpers
  include NetSuiteHelpers

  let(:record) { :netsuite_location }
  let(:resource) { FactoryBot.create(record, ledger_id: 1137) }
  let(:client) { netsuite_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_delete_for_record
end
