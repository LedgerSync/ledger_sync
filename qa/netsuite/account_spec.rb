# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::NetSuite::Account, adaptor: :netsuite do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    LedgerSync::Account.new(
      name: "Test Account #{test_run_id}"
    )
  end

  # it_behaves_like 'a full netsuite resource'
  it_behaves_like 'a record with metadata'
  it_behaves_like 'a find'
end
