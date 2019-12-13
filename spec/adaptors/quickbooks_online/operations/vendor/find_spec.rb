# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Find do
  include QuickBooksOnlineHelpers
  let(:resource) { LedgerSync::Vendor.new(ledger_id: '123', display_name: 'Test Tester')}
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_vendor
end
