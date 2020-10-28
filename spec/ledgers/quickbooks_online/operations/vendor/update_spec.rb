# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Vendor::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:resource) do
    build(
      :quickbooks_online_vendor,
      ledger_id: '123',
      GivenName: 'Sample',
      FamilyName: 'Vendor',
      MiddleName: nil,
      CompanyName: nil,
      PrimaryEmailAddr: build(
        :quickbooks_online_primary_email_addr,
        Address: 'test@example.com'
      ),
      PrimaryPhone: nil,
      DisplayName: 'Sample Vendor'
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_vendor_find
                    stub_vendor_update
                  ]
end
