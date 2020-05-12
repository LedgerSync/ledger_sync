# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::LedgerClass, qa: true, connection: :netsuite do
  let(:connection) { netsuite_connection }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :ledger_class }
  let(:resource) do
    LedgerSync::LedgerClass.new(
      external_id: "ledger_class_#{test_run_id}",
      name: "Test Ledger Class #{test_run_id}"
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
