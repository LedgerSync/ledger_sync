# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      memo: "QA UPDATE #{rand_id}"
    }
  end

  let(:account) do
    create_resource_for(
      adaptor: adaptor,
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
