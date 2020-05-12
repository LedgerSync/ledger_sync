# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
:operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Account::Operations::Create do
  include QuickBooksOnlineHelpers
  include InputHelpers

  let(:resource) do
    LedgerSync::Account.new(account_resource)
  end
  let(:connection) { quickbooks_online_connection }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_account
end
