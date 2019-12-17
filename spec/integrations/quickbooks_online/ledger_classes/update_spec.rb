# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/ledger_classes/update', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before do
    stub_find_ledger_class
    stub_update_ledger_class
  end

  let(:resource) do
    LedgerSync::LedgerClass.new(ledger_class_resource(ledger_id: '123'))
  end

  let(:input) do
    {
      adaptor: quickbooks_online_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Update.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
