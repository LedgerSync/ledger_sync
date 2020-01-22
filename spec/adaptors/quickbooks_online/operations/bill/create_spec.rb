# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Bill::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  # Account 1 needs to be Liability account
  let(:account1) do
    FactoryBot.create(
      :account,
      :without_test_run_id,
      ledger_id: 123
    )
  end

  # Account 2 needs to be different
  let(:account2) do
    FactoryBot.create(
      :account,
      :without_test_run_id,
      ledger_id: 124
    )
  end

  let(:vendor) do
    FactoryBot.create(
      :vendor,
      :without_test_run_id,
      ledger_id: 123
    )
  end

  let(:line_item_1) do
    FactoryBot.create(
      :bill_line_item,
      :without_test_run_id,
      account: account2
    )
  end

  let(:line_item_2) do
    FactoryBot.create(
      :bill_line_item,
      :without_test_run_id,
      account: account2
    )
  end

  let(:resource) do
    FactoryBot.create(
      :bill,
      :without_test_run_id,
      account: account1,
      vendor: vendor,
      line_items: [
        line_item_1,
        line_item_2
      ]
    )
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_bill
end
