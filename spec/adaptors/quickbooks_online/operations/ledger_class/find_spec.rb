require 'spec_helper'

support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Find do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::LedgerClass.new(ledger_id: '123', name: 'Test Class', active: true, sub_class: false)}
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_ledger_class
end
