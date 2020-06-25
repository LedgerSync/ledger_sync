# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(
      ledger_id: '123',
      Name: 'Test Class',
      FullyQualifiedName: nil,
      Active: true,
      SubClass: false
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_ledger_class
                    stub_update_ledger_class
                  ]
end
