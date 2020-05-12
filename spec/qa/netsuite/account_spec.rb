# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Account, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    FactoryBot.create(
      :account,
      account_type: 'Income',
      number: '100199'
    )
  end

  # it_behaves_like 'a full netsuite resource'
  # it_behaves_like 'a record with metadata'
  # it_behaves_like 'a find'
  it_behaves_like 'a searcher'
end
