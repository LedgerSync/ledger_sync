require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/payments/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_create_customer

    stub_create_payment
  }

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :p1,
      resource_type: 'payment',
      method: :create,
      resources_data: payment_resources
    }
  end

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input).operations }
    it { expect(subject.length).to eq(2) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Create) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
