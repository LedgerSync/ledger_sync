require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Create do
  include AdaptorHelpers

  let(:ledger_class) { LedgerSync::LedgerClass.new(name: 'Test', active: true, sub_class: false) }

  it do
    instance = described_class.new(resource: ledger_class, adaptor: quickbooks_adaptor)
    instance.valid?
    expect(instance).to be_valid
  end
end
