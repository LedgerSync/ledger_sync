# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Location::Operations::Delete do
  include InputHelpers
  include NetSuiteHelpers

  let(:record) { :location }
  let(:resource) { FactoryBot.create(record, ledger_id: 1137) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_delete_for_record
end
