# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:entity) do
    LedgerSync::Vendor.new(vendor_resource(ledger_id: '123'))
  end

  let(:line_item_1) do
    LedgerSync::ExpenseLineItem.new(expense_line_item_resource(account: account))
  end

  let(:line_item_2) do
    LedgerSync::ExpenseLineItem.new(expense_line_item_resource(account: account))
  end

  let(:resource) do
    LedgerSync::Expense.new(
      expense_resource(
        account: account,
        entity: entity,
        line_items: [
          line_item_1,
          line_item_2
        ]
      )
    )
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_expense
end
