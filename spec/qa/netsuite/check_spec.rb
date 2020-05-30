# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::NetSuite::Check, qa: true, client: :netsuite do
  let(:client) { netsuite_client }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :netsuite_check }
  let(:resource) do
    LedgerSync::Ledgers::NetSuite::Check.new(
      memo: "Hello World",
      trandate: "2020-06-01",
      entity: LedgerSync::Ledgers::NetSuite::Vendor.new(ledger_id: 52),
      account: LedgerSync::Ledgers::NetSuite::Account.new(ledger_id: 316),
      department: nil,
      currency: LedgerSync::Ledgers::NetSuite::Currency.new(ledger_id: 1),
      external_id: "external_id_test_#{test_run_id}",
      line_items: [
        LedgerSync::Ledgers::NetSuite::CheckLineItem.new(
          amount: 12.20,
          account: LedgerSync::Ledgers::NetSuite::Account.new(ledger_id: 227),
          department: nil
        )
      ]
    )
  end

  it_behaves_like 'a full netsuite resource CRUD'
  it_behaves_like 'a searcher'
end
