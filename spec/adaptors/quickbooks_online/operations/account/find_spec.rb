require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Find do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', account_type: 'bank')}

  it do
    instance = described_class.new(resource: account, adaptor: quickbooks_adaptor)
    expect(instance).to be_valid
  end
end
