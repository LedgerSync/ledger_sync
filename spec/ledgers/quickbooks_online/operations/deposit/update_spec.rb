# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Update do
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
      DisplayName: 'Sample Vendor'
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
      :quickbooks_online_deposit_line,
      Amount: 12_345,
      Description: 'Sample Transaction 1',
      DepositLineDetail: build(
        :quickbooks_online_deposit_line_detail,
        Account: account,
        Class: ledger_class,
        Entity: entity
      )
    )
  end

  let(:line_item_2) do
    build(
      :quickbooks_online_deposit_line,
      Amount: 12_345,
      Description: 'Sample Transaction 2',
      DepositLineDetail: build(
        :quickbooks_online_deposit_line_detail,
        Account: account,
        Class: ledger_class,
        Entity: nil
      )
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
      ledger_id: '123',
      DepositToAccount: account,
      Department: department,
      Currency: currency,
      PrivateNote: 'Memo',
      ExchangeRate: 1.0,
      TxnDate: Date.parse('2019-09-01'),
      Line: [
        line_item_1,
        line_item_2
      ]
    )
  end

  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_deposit_find
                    stub_deposit_update
                  ]
end
