# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Currency, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :currency }
  let(:resource) do
    FactoryBot.create(:netsuite_currency, symbol: 'ABC')
  end

  it_behaves_like 'a full netsuite resource'
end
