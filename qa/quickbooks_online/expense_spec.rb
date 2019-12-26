# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense, adaptor: :quickbooks_online do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      display_name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :vendor }
  let(:resource) { Resources.expense }

  it 'creates' do
    account = create_result_for(
      adaptor: adaptor,
      resource: Resources.account
    ).raise_if_error.resource

    vendor = create_result_for(
      adaptor: adaptor,
      resource: Resources.vendor
    ).raise_if_error.resource

    expense_line_item_1 = LedgerSync::ExpenseLineItem.new(
      account: account,
      amount: 12_345,
      description: "Test #{test_run_id} Line Item 1"
    )

    expense_line_item_2 = LedgerSync::ExpenseLineItem.new(
      account: account,
      amount: 23_456,
      description: "Test #{test_run_id} Line Item 2"
    )

    result = create_result_for(
      operation
    )



    operation = LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create.new(
      adaptor: quickbooks_online_adaptor,
      resource: expense
    )
  end
end
