# frozen_string_literal: true

require 'spec_helper'

core_support :operation_shared_examples
support :input_helpers,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:currency) do
    build(
      :quickbooks_online_currency,
      Name: 'United States Dollar',
      Symbol: 'USD'
    )
  end

  let(:account) do
    build(
      :quickbooks_online_account,
      ledger_id: '123'
    )
  end

  let(:resource) do
    build(
      :quickbooks_online_transfer,
      ledger_id: '123',
      FromAccount: account,
      ToAccount: account,
      Currency: currency,
      Amount: 12_345,
      PrivateNote: 'Memo',
      TxnDate: Date.parse('2019-09-01')
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_transfer_find
                    stub_transfer_update
                  ]
end
