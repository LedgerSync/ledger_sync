# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Invoice::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource(ledger_id: '123'))
  end

  let(:account) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:item) do
    LedgerSync::Item.new(ledger_id: '123')
  end

  let(:line_item) do
    LedgerSync::InvoiceSalesLineItem.new(invoice_line_item_resource({item: item, amount: 100, description: 'Sample Description'}))
  end

  let(:resource) do
    LedgerSync::Invoice.new(invoice_resource(ledger_id: '123', customer: customer, account: account, line_items: [line_item]))
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
  stubs: %i[
    stub_find_invoice
    stub_update_invoice
  ]
end
