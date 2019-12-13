# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Deposit::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand')}
  let(:resource) { LedgerSync::Deposit.new(account: account, currency: 'USD', memo: 'Memo 1', transaction_date: Date.new(2019, 9, 1), line_items: [])}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
