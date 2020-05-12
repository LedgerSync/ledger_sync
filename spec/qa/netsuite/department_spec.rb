# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Department, qa: true, connection: :netsuite do
  let(:connection) { netsuite_connection }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :department }
  let(:resource) do
    LedgerSync::Department.new(
      external_id: "department_#{test_run_id}",
      name: "Test Department #{test_run_id}"
    )
  end

  it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a searcher'
end
