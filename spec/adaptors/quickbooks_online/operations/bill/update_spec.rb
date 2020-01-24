# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Bill::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  # Account 1 needs to be Liability account
  let(:account1) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  # Account 2 needs to be different
  let(:account2) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:vendor) do
    LedgerSync::Vendor.new(vendor_resource(ledger_id: '123'))
  end

  let(:department) do
    LedgerSync::Department.new(ledger_id: '123')
  end

  let(:ledger_class) do
    LedgerSync::LedgerClass.new(ledger_id: '123')
  end

  let(:line_item_1) do
    LedgerSync::BillLineItem.new(bill_line_item_resource(account: account2, ledger_class: ledger_class))
  end

  let(:line_item_2) do
    LedgerSync::BillLineItem.new(bill_line_item_resource(account: account2, ledger_class: ledger_class))
  end

  let(:resource) do
    LedgerSync::Bill.new(
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

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_bill
                    stub_update_bill
                  ]
end
