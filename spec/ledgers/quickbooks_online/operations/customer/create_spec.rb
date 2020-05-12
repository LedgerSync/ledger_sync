# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:connection) { quickbooks_online_connection }
  let(:resource) { LedgerSync::Customer.new(customer_resource) }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_customer_create
end
