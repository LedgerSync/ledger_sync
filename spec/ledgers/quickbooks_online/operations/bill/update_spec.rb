# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  # Account 1 needs to be Liability account
  let(:account1) do
    build(:quickbooks_online_account, ledger_id: '123')
  end

  # Account 2 needs to be different
  let(:account2) do
    build(:quickbooks_online_account, ledger_id: '123')
  end

  let(:vendor) do
    build(:quickbooks_online_vendor, ledger_id: '123')
  end

  let(:department) do
    build(:quickbooks_online_department, ledger_id: '123')
  end

  let(:ledger_class) do
    build(:quickbooks_online_ledger_class, ledger_id: '123')
  end

  let(:line_item_1) do
    LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(
      bill_line_item_resource(account: account2, ledger_class: ledger_class)
    )
  end

  let(:line_item_2) do
    LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(
      bill_line_item_resource(account: account2, ledger_class: ledger_class)
    )
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Bill.new(
      bill_resource(
        ledger_id: '123',
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
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_bill
                    stub_update_bill
                  ]
end
