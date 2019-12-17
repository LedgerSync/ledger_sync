# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Transfer::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:resource) do
    LedgerSync::Transfer.new(
      transfer_resource(
        ledger_id: '123',
        from_account: account,
        to_account: account
      )
    )
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
  stubs: %i[
    stub_find_transfer
    stub_update_transfer
  ]
end
