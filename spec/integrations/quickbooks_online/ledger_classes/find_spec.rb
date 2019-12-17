require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/ledger_classes/find', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before {
    stub_find_ledger_class
  }

  let(:resource) do
    LedgerSync::LedgerClass.new(ledger_class_resource({ledger_id: 123}))
  end

  let(:input) do
    {
      adaptor: quickbooks_online_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
