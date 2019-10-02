require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/expenses/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_find_account
    stub_update_account

    stub_find_vendor
    stub_update_vendor

    stub_find_expense
    stub_update_expense
  }
  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :e1,
      resource_type: 'expense',
      method: :update,
      resources_data: expense_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input).operations }
    it { expect(subject.length).to eq(3) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Update) }
    it { expect(subject.last).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end
end
