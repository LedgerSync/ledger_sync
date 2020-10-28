# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Vendor::Operations::Find do
  include QuickBooksOnlineHelpers
  let(:resource) do
    build(
      :quickbooks_online_vendor,
      ledger_id: '123'
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_vendor_find
end
