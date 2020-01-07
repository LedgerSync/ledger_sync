# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{rand_id}"
    }
  end
  let(:resource) { FactoryBot.create(:customer) }

  it_behaves_like 'a standard quickbooks_online resource'
end
