# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Find do
  include AdaptorHelpers

  let(:adaptor) { quickbooks_adaptor }
  let(:resource) { LedgerSync::Customer.new(ledger_id: '123', name: 'Test') }

  it_behaves_like 'an operation'
end
