# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Account::Operations::Update do
  include AdaptorHelpers

  let(:resource) { LedgerSync::Account.new(ledger_id: '123', name: 'Test', classification: 'asset', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
