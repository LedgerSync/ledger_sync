# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Invoice::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123') }
  let(:account) { LedgerSync::Account.new(ledger_id: '123') }
  let(:resource) { LedgerSync::Invoice.new(ledger_id: '123', customer: customer, account: account, line_items: []) }
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_invoice
end
