# frozen_string_literal: true

require 'spec_helper'

support :input_helpers,
        :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Update do
  include InputHelpers
  include QuickBooksOnlineHelpers

  let(:adaptor) do
    quickbooks_online_adaptor
  end
  let(:resource) do
    LedgerSync::Customer.new(customer_resource(ledger_id: '123'))
  end

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_customer_find
                    stub_customer_update
                  ]
end
