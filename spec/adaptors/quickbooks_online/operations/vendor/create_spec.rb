# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers
support :operation_shared_examples

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Vendor::Operations::Create do
  include AdaptorHelpers

  let(:resource) { LedgerSync::Vendor.new(display_name: 'Test Tester')}
  let(:adaptor) { quickbooks_adaptor }

  it_behaves_like 'an operation'
end
