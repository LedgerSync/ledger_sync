# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Ledgers::NetSuite::Location::Operations::Update do
  include InputHelpers
  include NetSuiteHelpers

  let(:record) { :location }
  let(:resource) { FactoryBot.create(record, ledger_id: 1137) }
  let(:connection) { netsuite_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_for_record
                    stub_update_for_record
                  ]
end
