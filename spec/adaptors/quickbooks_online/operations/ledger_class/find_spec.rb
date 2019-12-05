require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::LedgerClass::Operations::Find do
  include AdaptorHelpers

  let(:ledger_class) { LedgerSync::LedgerClass.new(ledger_id: '123', name: 'Test', active: true, sub_class: false)}

  it do
    instance = described_class.new(resource: ledger_class, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
