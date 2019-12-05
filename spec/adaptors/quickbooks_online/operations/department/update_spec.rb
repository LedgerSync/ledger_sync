require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Department::Operations::Update do
  include AdaptorHelpers

  let(:department) { LedgerSync::Department.new(ledger_id: '123', name: 'Test', active: true, sub_department: false)}

  it do
    instance = described_class.new(resource: department, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
