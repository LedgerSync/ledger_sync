# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Update do
  include AdaptorHelpers

  let(:resource) { LedgerSync::Vendor.new(ledger_id: '123', display_name: 'Test Tester')}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
