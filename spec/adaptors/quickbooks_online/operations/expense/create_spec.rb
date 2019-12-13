# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Expense::Operations::Create do
  include AdaptorHelpers

  let(:account) { LedgerSync::Account.new(name: 'Test', account_type: 'bank', account_sub_type: 'cash_on_hand') }
  let(:vendor) { LedgerSync::Vendor.new(first_name: 'Test', last_name: 'Testing') }
  let(:resource) { LedgerSync::Expense.new(account: account, entity: vendor, currency: 'USD', memo: 'Memo 1', payment_type: 'cash', transaction_date: Date.new(2019, 9, 1), line_items: []) }
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
