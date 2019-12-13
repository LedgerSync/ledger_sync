# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Create do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource(ledger_id: '123'))
  end

  let(:resource) do
    LedgerSync::Payment.new(payment_resource(customer: customer))
  end

  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation', stubs: :stub_create_payment
end
