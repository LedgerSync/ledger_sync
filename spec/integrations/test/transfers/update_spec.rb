require 'spec_helper'

support :input_helpers
support :adaptor_helpers

RSpec.describe 'test/transfers/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers

  let(:account) do
    LedgerSync::Account.new(account_resource({ledger_id: '123'}))
  end

  let(:resource) do
    LedgerSync::Transfer.new(
      transfer_resource(
        {
          ledger_id: '123',
          from_account: account,
          to_account: account,
        }
      )
    )
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Transfer::Operations::Update.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
