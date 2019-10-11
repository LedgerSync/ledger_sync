require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/accounts/find', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before {
    stub_find_account
  }

  let(:resource) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Find.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
