# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe(
  LedgerSync::Adaptors::QuickBooksOnline::Preferences::Operations::Find
) do
  include QuickBooksOnlineHelpers

  let(:resource) do
    LedgerSync::Adaptors::QuickBooksOnline::Preferences.new(ledger_id: nil)
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_preferences_find
end
