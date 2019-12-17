require 'spec_helper'

support :input_helpers
support :test_adaptor_helpers

RSpec.describe 'test/accounts/create', type: :feature do
  include InputHelpers
  include TestAdaptorHelpers

  let(:resource) do
    LedgerSync::Account.new(account_resource)
  end

  let(:input) do
    {
      adaptor: test_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::Test::Account::Operations::Create.new(**input).perform }
    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::OperationResult::Success)}
  end
end
