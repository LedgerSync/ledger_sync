# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Transfer::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:resource) do
    LedgerSync::Transfer.new(
      transfer_resource(
        from_account: account,
        to_account: account
      )
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_transfer
end
