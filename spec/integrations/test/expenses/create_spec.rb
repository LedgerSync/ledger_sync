require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/expenses/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:input) do
    {
      adaptor: test_adaptor,
      resource_external_id: :e1,
      resource_type: 'expense',
      method: :create,
      resources_data: expense_resources
    }
  end

  let(:sync) { LedgerSync::Sync.new(**input) }

  it { expect(sync).to be_valid }

  context '#operations' do
    subject { sync.operations }
    it { expect(subject.length).to eq(3) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::Test::Account::Operations::Create) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::Test::Expense::Operations::Create) }
  end

  context '#perform' do
    subject { sync.perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
