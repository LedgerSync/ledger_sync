require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/vendors/upsert', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_find_vendor
    stub_create_vendor
    stub_update_vendor
  }

  let(:input_create) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :v1,
      resource_type: 'vendor',
      method: :upsert,
      resources_data: vendor_resources
    }
  end

  it { expect(LedgerSync::Sync.new(**input_create)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_create).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Create) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_create).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end

  let(:input_update) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :v1,
      resource_type: 'vendor',
      method: :upsert,
      resources_data: vendor_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input_update)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_update).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_update).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
