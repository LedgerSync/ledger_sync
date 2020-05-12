# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::Client do
  include QuickBooksOnlineHelpers

  it { expect { described_class.new }.to raise_error(NotImplementedError) }

  subject { quickbooks_online_client }

  describe '#searcher_for' do
    it { expect(subject.searcher_for(resource_type: :customer)).to be_a(LedgerSync::Ledgers::QuickBooksOnline::Customer::Searcher) }
    it { expect { subject.searcher_for(resource_type: :asdf) }.to raise_error(NameError, 'uninitialized constant LedgerSync::Ledgers::QuickBooksOnline::Asdf') }
  end

  describe '#searcher_class_for' do
    it { expect(subject.searcher_class_for(resource_type: :customer)).to eq(LedgerSync::Ledgers::QuickBooksOnline::Customer::Searcher) }
  end

  describe '#ledger_attributes_to_save' do
    it { expect { described_class.ledger_attributes_to_save }.to raise_error(NotImplementedError) }
    it { expect(subject.class.ledger_attributes_to_save).to eq(%i[access_token expires_at refresh_token refresh_token_expires_at]) }
  end
end
