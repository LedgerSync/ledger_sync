# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:resource) do
    FactoryBot.create(
      :account,
      :without_test_run_id,
      ledger_id: '123'
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
