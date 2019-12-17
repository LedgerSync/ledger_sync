require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::LedgerClass.new(name: 'Test Class', active: true, sub_class: false) }
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_ledger_class
end
