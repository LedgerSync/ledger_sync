# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Expense, qa: true, client: :quickbooks_online do
  let(:client) { quickbooks_online_client }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{rand_id}"
    }
  end

  let(:account) do
    create_resource_for(
      client: client,
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
