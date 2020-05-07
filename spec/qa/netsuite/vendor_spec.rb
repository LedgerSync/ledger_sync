# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Adaptors::NetSuite::Vendor, qa: true, adaptor: :netsuite do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      company_name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :vendor }
  let(:resource) do
    LedgerSync::Vendor.new(
      company_name: "#{test_run_id} Company",
      email: "test-#{test_run_id}-vendor@example.com",
      external_id: "vendor-#{test_run_id}",
      first_name: "TestFirst#{test_run_id}",
      last_name: "TestLast#{test_run_id}",
      display_name: "Test #{test_run_id} Display Name",
      subsidiary: existing_subsidiary_resource
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
