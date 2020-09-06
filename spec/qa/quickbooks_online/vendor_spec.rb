# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Vendor, qa: true, client: :quickbooks_online do
  let(:client) { quickbooks_online_client }
  let(:attribute_updates) do
    {
      DisplayName: "QA UPDATE #{rand_id}"
    }
  end
  let(:resource) do
    build(
      :quickbooks_online_vendor,
      PrimaryEmailAddr: build(
        :quickbooks_online_primary_email_addr,
        Address: "test-#{rand(1000)}@example.com"
      ),
      PrimaryPhone: build(
        :quickbooks_online_primary_phone,
        FreeFormNumber: "+1#{rand(9_999_999_99)}"
      )
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end
