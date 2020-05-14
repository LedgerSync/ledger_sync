# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  # Account 1 needs to be Liability account
  let(:account1) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  # Account 2 needs to be different
  let(:account2) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  let(:vendor) do
    LedgerSync::Ledgers::QuickBooksOnline::Vendor.new(vendor_resource(ledger_id: '123'))
  end

  let(:department) do
    LedgerSync::Ledgers::QuickBooksOnline::Department.new(ledger_id: '123')
  end

  let(:ledger_class) do
    LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: '123')
  end

  let(:line_item_1) do
    LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(bill_line_item_resource(account: account2, ledger_class: ledger_class))
  end

  let(:line_item_2) do
    LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(bill_line_item_resource(account: account2, ledger_class: ledger_class))
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Bill.new(
      bill_resource(
        account: account1,
        department: department,
        vendor: vendor,
        line_items: [
          line_item_1,
          line_item_2
        ]
      )
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_bill
end
