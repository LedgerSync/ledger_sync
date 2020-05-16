require 'spec_helper'

support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::LedgerClass::Operations::Find do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: '123', name: 'Test Class', active: true, sub_class: false)}
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_ledger_class
end
