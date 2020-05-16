# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(account_resource(ledger_id: '123'))
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Transfer.new(
      transfer_resource(
        ledger_id: '123',
        from_account: account,
        to_account: account
      )
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
  stubs: %i[
    stub_find_transfer
    stub_update_transfer
  ]
end
