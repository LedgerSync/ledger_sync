require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Department.new(name: 'Test Department', active: true, sub_department: false) }
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_department
end
