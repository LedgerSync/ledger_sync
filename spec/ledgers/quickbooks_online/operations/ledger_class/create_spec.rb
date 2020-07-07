# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers,
        :operation_shared_examples

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(
      name: 'Test Class',
      active: true,
      sub_class: false
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_ledger_class
end
