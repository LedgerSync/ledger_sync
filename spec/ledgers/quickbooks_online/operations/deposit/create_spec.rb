# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  let(:entity) do
    LedgerSync::Ledgers::QuickBooksOnline::Vendor.new(vendor_resource(ledger_id: '245'))
  end

  let(:department) do
    LedgerSync::Ledgers::QuickBooksOnline::Department.new(ledger_id: '123')
  end

  let(:ledger_class) do
    LedgerSync::Ledgers::QuickBooksOnline::LedgerClass.new(ledger_id: '123')
  end

  let(:line_item_1) do
    LedgerSync::Ledgers::QuickBooksOnline::DepositLineItem.new(deposit_line_item_resource(account: account, ledger_class: ledger_class, entity: entity))
  end

  let(:line_item_2) do
    LedgerSync::Ledgers::QuickBooksOnline::DepositLineItem.new(deposit_line_item_resource(account: account, ledger_class: ledger_class))
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Deposit.new(
      deposit_resource(
        account: account,
        department: department,
        line_items: [
          line_item_1,
          line_item_2
        ]
      )
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_deposit
end
