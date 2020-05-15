# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Update do
  include QuickBooksOnlineHelpers

  let(:client) { quickbooks_online_client }
  let(:resource) do
    create(
      :quickbooks_online_customer,
      external_id: :ext_id,
      ledger_id: 123,
      PrimaryEmailAddr: create(
        :quickbooks_online_primary_email_addr,
        Address: 'test@example.com'
      ),
      PrimaryPhone: nil,
      DisplayName: 'Sample Customer'
    )
  end

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: %i[
                    stub_customer_find
                    stub_customer_update
                  ]

  context 'with a ResourceAdaptor' do
    let(:resource) do
      LedgerSync::Bundles::ModernTreasury::Adaptors::QuickBooksOnline::Customer.new(
        resource: new_resource_class(
          attributes: %i[
            email
            name
            phone
          ]
        ).new(
          external_id: :ext_id,
          ledger_id: 123,
          email: 'test@example.com',
          phone: nil,
          name: 'Sample Customer'
        )
      )
    end

    it_behaves_like 'an operation'
    it_behaves_like 'a successful operation',
                    stubs: %i[
                      stub_customer_find
                      stub_customer_update
                    ]
  end
end
