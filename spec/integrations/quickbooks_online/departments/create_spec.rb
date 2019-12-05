# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/departments/create', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_create_department
  end

  let(:parent) do
    LedgerSync::Department.new(department_resource({ledger_id: 1}))
  end

  let(:resource) do
    LedgerSync::Department.new(department_resource({parent: parent}))
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Department::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
