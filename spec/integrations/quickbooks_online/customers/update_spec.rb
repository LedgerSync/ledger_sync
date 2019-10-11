require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/customers/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before {
    stub_find_customer
    stub_update_customer
  }

  let(:resource) do
    LedgerSync::Customer.new(customer_resource({ledger_id: 123}))
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Update.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
