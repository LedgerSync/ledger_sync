require 'spec_helper'

support :input_helpers
support :test_adaptor_helpers

RSpec.describe 'test/expenses/create', type: :feature do
  include InputHelpers
  include TestAdaptorHelpers

  let(:account) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:vendor) do
    LedgerSync::Vendor.new(vendor_resource({ledger_id: '123'}))
  end

  let(:line_item_1) do
    LedgerSync::ExpenseLineItem.new(expense_line_item_resource({account: account}))
  end

  let(:line_item_2) do
    LedgerSync::ExpenseLineItem.new(expense_line_item_resource({account: account}))
  end

  let(:resource) do
    LedgerSync::Expense.new(
      expense_resource(
        {
          account: account,
          entity: vendor,
          line_items: [
            line_item_1,
            line_item_2
          ]
        }
      )
    )
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Expense::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
