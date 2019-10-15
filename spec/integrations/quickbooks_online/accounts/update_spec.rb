# frozen_string_literal: true

require 'spec_helper'

support :input_helpers
support :adaptor_helpers
support :quickbooks_helpers

RSpec.describe 'quickbooks_online/accounts/update', type: :feature do
  include InputHelpers
  include AdaptorHelpers
  include QuickBooksHelpers

  before do
    stub_find_account
    stub_update_account
  end

  let(:resource) do
    LedgerSync::Account.new(account_resource(ledger_id: '123'))
  end

  let(:input) do
    {
      adaptor: quickbooks_adaptor,
      resource: resource
    }
  end

  context '#perform' do
    subject { LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Update.new(**input).perform }

    xit { expect(subject).to be_a(LedgerSync::OperationResult::Success) }
  end
end
