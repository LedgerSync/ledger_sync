require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Operations::Create do
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::Department.new(name: 'Test Department', active: true, sub_department: false) }
  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_department
end
