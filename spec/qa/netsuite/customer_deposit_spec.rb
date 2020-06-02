# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::CustomerDeposit, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      payment: 10.00
    }
  end
  let(:record) { :customerDeposit }
  let(:resource) do
    LedgerSync::Ledgers::NetSuite::CustomerDeposit.new(
      payment: 30.00,
      undepFunds: false,
      external_id: "customer_#{test_run_id}",
      customer: existing_customer_resource,
      account: existing_account_resource
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
