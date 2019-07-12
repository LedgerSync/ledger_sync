require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/payments/upsert', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_find_customer
    stub_create_customer
    stub_update_customer

    stub_find_payment
    stub_create_payment
    stub_update_payment
  }

  let(:input_create) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :p1,
      resource_type: 'payment',
      method: :upsert,
      resources_data: payment_resources
    }
  end

  it { expect(LedgerSync::Sync.new(**input_create)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_create).operations }
    it { expect(subject.length).to eq(2) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Create) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_create).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end

  let(:input_update) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :p1,
      resource_type: 'payment',
      method: :upsert,
      resources_data: payment_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input_update)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_update).operations }
    it { expect(subject.length).to eq(2) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Update) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_update).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
