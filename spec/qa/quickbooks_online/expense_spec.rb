# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense, qa: true, connection: :quickbooks_online do
  let(:connection) { quickbooks_online_connection }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{rand_id}"
    }
  end

  let(:account) do
    create_resource_for(
      connection: connection,
      resource: FactoryBot.create(:account)
    )
  end

  let(:resource) do
    FactoryBot.create(
      :expense,
      account: account,
      line_items: FactoryBot.create_list(
        :expense_line_item,
        2,
        account: account
      )
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end
