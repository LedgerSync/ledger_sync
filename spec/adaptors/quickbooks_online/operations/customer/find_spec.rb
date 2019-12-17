# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Find do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:adaptor) { quickbooks_online_adaptor }
  let(:resource) { LedgerSync::Customer.new(customer_resource(ledger_id: 123)) }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_find_customer
end
