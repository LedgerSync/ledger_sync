# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account, qa: true, connection: :quickbooks_online do
  let(:connection) { quickbooks_online_connection }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :account }
  let(:resource) { FactoryBot.create(:account) }

  it_behaves_like 'a standard quickbooks_online resource'
end
