# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:resource) { LedgerSync::Department.new(ledger_id: '123', name: 'Test', active: true, sub_department: false) }
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_department
end
