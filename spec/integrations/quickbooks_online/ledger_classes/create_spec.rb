# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/ledger_classes/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_create_ledger_class
  end

  let(:resource) do
    LedgerSync::LedgerClass.new(ledger_class_resource())
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
