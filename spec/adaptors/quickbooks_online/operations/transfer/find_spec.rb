# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Transfer::Operations::Find do
  include AdaptorHelpers

  let(:from_account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test 1', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:to_account) { LedgerSync::Account.new(ledger_id: '123', name: 'Test 2', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:resource) { LedgerSync::Transfer.new(ledger_id: '123', from_account: from_account, to_account: to_account, amount: 0, currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1))}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
