# frozen_string_literal: true

RSpec.describe LedgerSync::Adaptors::NetSuite::Customer, adaptor: :netsuite do
  let(:adaptor) { netsuite_adaptor }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :customer }
  let(:resource) do
    LedgerSync::Customer.new(
      email: "#{test_run_id}@example.com",
      name: "Test Customer #{test_run_id}",
      phone_number: '1234567890',
      subsidiary: existing_subsidiary_resource
    )
  end

  it_behaves_like 'a full netsuite resource'
end
