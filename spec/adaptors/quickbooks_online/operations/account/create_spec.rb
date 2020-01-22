# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Create do
  include QuickBooksOnlineHelpers
  include InputHelpers

  let(:resource) do
    FactoryBot.create(
      :account,
      :no_test_run_id
    )
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_account
end
