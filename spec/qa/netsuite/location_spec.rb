# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Department, qa: true, connection: :netsuite do
  let(:connection) { netsuite_connection }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :location }
  let(:resource) do
    FactoryBot.create(record)
  end

  it_behaves_like 'a full netsuite resource'
end
