# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    LedgerSync::Account.new(
      name: "Test Account #{test_run_id}",
      classification: 'asset',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand',
      currency: 'usd',
      description: "Test #{test_run_id} Account description",
      active: true
    )
  end

  it_behaves_like 'a standard quickbooks_online resource'
end
