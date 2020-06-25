# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    build(
      :quickbooks_online_account,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:entity) do
    build(
      :quickbooks_online_vendor,
      external_id: :ext_id,
      ledger_id: '123',
      display_name: 'Sample Vendor'
    )
  end

  let(:department) do
    build(
      :quickbooks_online_department,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:ledger_class) do
    build(
      :quickbooks_online_ledger_class,
      external_id: :ext_id,
      ledger_id: '123'
    )
  end

  let(:line_item_1) do
    build(
      :quickbooks_online_deposit_line_item,
      account: account,
      ledger_class: ledger_class,
      entity: entity,
      amount: 12_345,
      description: 'Sample Transaction'
    )
  end

  let(:line_item_2) do
    build(
      :quickbooks_online_deposit_line_item,
      account: account,
      ledger_class: ledger_class,
      entity: nil,
      amount: 12_345,
      description: 'Sample Transaction'
    )
  end

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_deposit,
      account: account,
      department: department,
      currency: currency,
      memo: 'Memo',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01'),
      line_items: [
        line_item_1,
        line_item_2
      ]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_deposit
end
