# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:customer) { LedgerSync::Ledgers::QuickBooksOnline::Customer.new(ledger_id: '123') }
  let(:account) { LedgerSync::Ledgers::QuickBooksOnline::Account.new(ledger_id: '123') }
  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Invoice.new(ledger_id: '123', customer: customer, account: account, line_items: []) }
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_invoice
end
