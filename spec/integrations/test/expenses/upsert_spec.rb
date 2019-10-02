require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/expenses/upsert', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input_create) do
    {
      adaptor: test_adaptor,
      resource_external_id: :e1,
      resource_type: 'expense',
      method: :upsert,
      resources_data: expense_resources
    }
  end

  it { expect(LedgerSync::Sync.new(**input_create)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_create).operations }
    it { expect(subject.length).to eq(3) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Account::Operations::Create) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::Test::Expense::Operations::Create) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_create).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end

  let(:input_update) do
    {
      adaptor: test_adaptor,
      resource_external_id: :e1,
      resource_type: 'expense',
      method: :upsert,
      resources_data: expense_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input_update)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input_update).operations }
    it { expect(subject.length).to eq(3) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Account::Operations::Update) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::Test::Expense::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input_update).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
