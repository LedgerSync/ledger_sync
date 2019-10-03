require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/customers/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickbooksHelpers

  before {
    stub_find_customer
    stub_update_customer
  }

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource_external_id: :c1,
      resource_type: 'customer',
      method: :update,
      resources_data: customer_resources(ledger_id: '123')
    }
  end

  it { expect(LedgerSync::Sync.new(**input)).to be_valid }

  context '#operations' do
    subject { LedgerSync::Sync.new(**input).operations }
    it { expect(subject.length).to eq(1) }
    it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Update) }
  end

  context '#perform' do
    subject { LedgerSync::Sync.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
  end

  describe 'zero input' do
    let(:zero_input) do
      {
        adaptor: quickbooks_adaptor,
        resource_external_id: :c1,
        resource_type: 'customer',
        method: :update,
        resources_data: customer_resources(ledger_id: '123', data: {})
      }
    end

    it { expect(LedgerSync::Sync.new(**zero_input)).to be_valid }

    context '#operations' do
      subject { LedgerSync::Sync.new(**zero_input).operations }
      it { expect(subject.length).to eq(1) }
      it { expect(subject.first).to be_a(LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Update) }
    end

    context '#perform' do
      subject { LedgerSync::Sync.new(**zero_input).perform }
      it { expect(subject).to be_success }
      it { expect(subject).to be_a(LedgerSync::SyncResult::Success) }
    end
  end
end
