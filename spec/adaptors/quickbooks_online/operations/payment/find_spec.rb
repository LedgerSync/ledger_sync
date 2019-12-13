# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:customer) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test') }
  let(:resource) { LedgerSync::Payment.new(ledger_id: '123', amount: 150, currency: 'USD', customer: customer) }
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_payment
end
