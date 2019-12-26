# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account, adaptor: :quickbooks_online do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) { Resources.account }

  it_behaves_like 'a standard quickbooks_online resource'
end
