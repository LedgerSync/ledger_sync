# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Create do
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
      ledger_id: nil,
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
  it_behaves_like 'a successful operation', stubs: :stub_transfer_create
end
