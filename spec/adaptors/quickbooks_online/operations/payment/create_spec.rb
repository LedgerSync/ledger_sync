# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource(ledger_id: '123'))
  end

  let(:invoice) do
    LedgerSync::Invoice.new({ledger_id: '123'})
  end

  let(:txn) do
    LedgerSync::Txn.new(linked_txn_resource({entity: invoice}))
  end

  let(:line_item) do
    LedgerSync::PaymentLineItem.new(payment_line_item_resource({amount: 100, linked_txns: [txn]}))
  end

  let(:resource) do
    LedgerSync::Payment.new(payment_resource(customer: customer, line_items: [line_item]))
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_payment
end
