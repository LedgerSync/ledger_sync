# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account, qa: true, client: :quickbooks_online do
  let(:client) { quickbooks_online_client }
  let(:attribute_updates) do
    {
      Name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :account }
  let(:resource) do
    build(
      :quickbooks_online_account,
      AcctNum: rand(10_000).to_s,
      AccountType: 'bank',
      Classification: 'asset',
      AccountSubType: 'cash_on_hand'
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end
