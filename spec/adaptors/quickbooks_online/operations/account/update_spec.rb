# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:resource) do
    LedgerSync::Account.new(
      account_sub_type: 'cash_on_hand',
      account_type: 'bank',
      active: true,
      classification: 'asset',
      currency: 'USD',
      description: 'This is Sample Account',
      ledger_id: '123',
      name: 'Sample Account'
    )
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_find_account
                    stub_update_account
                  ]
end
