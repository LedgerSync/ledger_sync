# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    create(
      :quickbooks_online_customer,
      external_id: :ext_id,
      ledger_id: 123,
      PrimaryEmailAddr: create(
        :quickbooks_online_primary_email_addr,
        Address: 'test@example.com'
      ),
      PrimaryPhone: nil,
      DisplayName: 'Sample Customer'
    )
  end

  let(:account) do
    create(
      :quickbooks_online_account,
      ledger_id: 123
    )
  end

  let(:item) do
    create(
      :quickbooks_online_item,
      ledger_id: 123
    )
  end

  let(:line_item) do
    create(
      :quickbooks_online_invoice_sales_line_item,
      ledger_id: nil,
      ledger_class: create(
        :quickbooks_online_ledger_class,
        ledger_id: nil
      ),
      item: item,
      amount: 100,
      description: 'Sample Description'
    )
  end

  let(:resource) do
    create(
      :quickbooks_online_invoice,
      ledger_id: 123,
      customer: customer,
      currency: create(
        :quickbooks_online_currency,
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      account: account,
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      line_items: [line_item]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_invoice
                    stub_update_invoice
                  ]
end
