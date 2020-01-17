# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::NetSuite::Currency::Operations::Update do
  include InputHelpers
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create(:currency, ledger_id: 2) }
  let(:adaptor) { netsuite_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_currency_find
                    stub_currency_update
                  ]
end