# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Payment::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:customer) do
    LedgerSync::Customer.new(customer_resource({ledger_id: '123'}))
  end

  let(:resource) do
    LedgerSync::Payment.new(payment_resource({ledger_id: '123', customer: customer}))
  end

  let(:input) do
    {
      adaptor: quickbooks_online_adaptor,
      resource: resource
    }
  end
  let(:adaptor) { quickbooks_online_adaptor }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
  stubs: %i[
    stub_find_payment
    stub_update_payment
  ]
end
