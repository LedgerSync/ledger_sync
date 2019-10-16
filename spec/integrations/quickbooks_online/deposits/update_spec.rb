# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/deposits/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_find_deposit
    stub_update_deposit
  end

  let(:account) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:line_item_1) do
    LedgerSync::DepositLineItem.new(deposit_line_item_resource(account: account))
  end

  let(:line_item_2) do
    LedgerSync::DepositLineItem.new(deposit_line_item_resource(account: account))
  end

  let(:resource) do
    LedgerSync::Deposit.new(
      deposit_resource(
        ledger_id: '123',
        account: account,
        line_items: [
          line_item_1,
          line_item_2
        ]
      )
    )
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Deposit::Operations::Update.new(**input).perform }

    # TODO: problem here is that sometims we want to the local values to take precedence and sometimes not.
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end