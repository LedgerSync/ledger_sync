# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/departments/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_find_department
    stub_update_department
  end

  let(:resource) do
    LedgerSync::Department.new(department_resource(ledger_id: '123'))
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Department::Operations::Update.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
