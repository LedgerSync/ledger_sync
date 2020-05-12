# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Vendor::Operations::Find do
  include QuickBooksOnlineHelpers
  let(:resource) { LedgerSync::Vendor.new(ledger_id: '123', display_name: 'Test Tester')}
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_vendor
end
