# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuiteSOAP::Customer, qa: true, client: :netsuite_soap do
  let(:client) { netsuite_soap_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{rand_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    LedgerSync::Customer.new(
      email: "#{rand_id}@example.com",
      name: "Test Customer #{rand_id}",
      phone_number: '1234567890',
      subsidiary: existing_subsidiary_resource
    )
  end

  it_behaves_like 'a full netsuite soap resource'
end
