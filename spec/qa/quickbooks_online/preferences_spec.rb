# frozen_string_literal: true

RSpec.describe(
  LedgerSync::Ledgers::QuickBooksOnline::Preferences,
  qa: true,
  client: :quickbooks_online
) do
  let(:client) { quickbooks_online_client }
  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Preferences.new }

  it_behaves_like 'a find only quickbooks_online resource'
end
