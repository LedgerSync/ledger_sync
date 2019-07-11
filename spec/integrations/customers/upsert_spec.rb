require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'customers/upsert', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input_create) do
    {
      adaptor: test_adaptor,
      resource_external_id: :c1,
      resource_type: 'customer',
      method: :upsert,
      resources_data: customer_resources
    }
  end

  it { expect(LedgerSync::Sync.new(**input_create)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_create).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Customer::Operations::Create) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_create).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end

  let(:input_update) do
    {
      adaptor: test_adaptor,
      resource_external_id: :c1,
      resource_type: 'customer',
      method: :upsert,
      resources_data: customer_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input_update)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_update).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Customer::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_update).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
