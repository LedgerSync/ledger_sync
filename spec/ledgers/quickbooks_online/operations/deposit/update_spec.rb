# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    create(
      :quickbooks_online_account,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:department) do
    create(
      :quickbooks_online_department,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:ledger_class) do
    create(
      :quickbooks_online_ledger_class,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:line_item_1) do
    LedgerSync::Ledgers::QuickBooksOnline::DepositLineItem.new(
      deposit_line_item_resource(account: account, ledger_class: ledger_class)
    )
  end

  let(:line_item_2) do
    LedgerSync::Ledgers::QuickBooksOnline::DepositLineItem.new(
      deposit_line_item_resource(account: account, ledger_class: ledger_class)
    )
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Deposit.new(
      deposit_resource(
        ledger_id: '123',
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
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_deposit
                    stub_update_deposit
                  ]
end
