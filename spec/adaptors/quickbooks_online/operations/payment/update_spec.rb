# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Update do
  include AdaptorHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test') }
  let(:resource) { LedgerSync::Payment.new(ledger_id: '123', amount: 150, currency: 'USD', customer: customer) }
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
