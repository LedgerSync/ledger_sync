# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::CustomerDeposit, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :netsuite_customer_deposit }
  let(:resource) do
    LedgerSync::Ledgers::NetSuite::CustomerDeposit.new(
      payment: 30.00,
      undepFunds: false,
      external_id: "customesr_#{test_run_id}",
      customer: existing_customer_resource,
      account: existing_account_resource
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
