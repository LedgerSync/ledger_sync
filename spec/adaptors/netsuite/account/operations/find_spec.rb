# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Account::Operations::Find do
  include InputHelpers
  include NetSuiteHelpers

  let(:resource) { LedgerSync::Account.new(ledger_id: 417) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_account_find
end
