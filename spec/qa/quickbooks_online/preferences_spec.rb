# frozen_string_literal: true

RSpec.describe(
  LedgerSync::Adaptors::QuickBooksOnline::Preferences,
  qa: true,
  adaptor: :quickbooks_online
) do
  let(:adaptor) { quickbooks_online_adaptor }
  let(:resource) { LedgerSync::Adaptors::QuickBooksOnline::Preferences.new }

  it_behaves_like 'a find only quickbooks_online resource'
end
