# frozen_string_literal: true

RSpec.describe(
  LedgerSync::Ledgers::QuickBooksOnline::Preferences,
  qa: true,
  connection: :quickbooks_online
) do
  let(:connection) { quickbooks_online_connection }
  let(:resource) { LedgerSync::Ledgers::QuickBooksOnline::Preferences.new }

  it_behaves_like 'a find only quickbooks_online resource'
end
