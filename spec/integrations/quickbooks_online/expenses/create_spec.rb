# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/expenses/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_create_expense
  end

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

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  describe '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }

    context 'when entity is a customer' do
      let(:entity) { LedgerSync::Customer.new(customer_resource(ledger_id: '123')) }

      before { stub_create_expense_with_cutomer_entity }

      it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
    end
  end
end
