# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:resource) do
    create(
      :quickbooks_online_account,
      external_id: :ext_id,
      ledger_id: '123',
      Name: 'Sample Account',
      Classification: 'asset',
      AccountType: 'bank',
      AccountSubType: 'cash_on_hand',
      Currency: build(
        :quickbooks_online_currency,
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      AcctNum: '123',
      Description: 'This is Sample Account',
      Active: true
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_account_find
                    stub_account_update
                  ]
end
