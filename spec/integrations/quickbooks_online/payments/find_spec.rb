require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/payments/find', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_find_payment
  }

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :p1,
      resource_type: 'payment',
      method: :find,
      resources_data: payment_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Find) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
