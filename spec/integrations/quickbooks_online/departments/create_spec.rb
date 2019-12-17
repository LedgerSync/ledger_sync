# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :quickbooks_online_helpers

RSpec.describe 'quickbooks_online/departments/create', type: :feature do
  include InputHelpers
  include QuickBooksOnlineHelpers

  before do
    stub_create_department
  end

  let(:resource) do
    LedgerSync::Department.new(department_resource())
  end

  let(:input) do
    {
      adaptor: quickbooks_online_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Department::Operations::Create.new(**input).perform }

    it { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
