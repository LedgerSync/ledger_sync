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
                  stubs: [
                    :stub_customer_find,
                    [
                      :stub_customer_update,
                      request_body: {
                        'Id' => '123',
                        'DisplayName' => 'Sample Customer',
                        'PrimaryPhone' => {
                          'FreeFormNumber' => nil
                        },
                        'PrimaryEmailAddr' => {
                          'Address' => 'test@example.com'
                        },
                        'Taxable' => true,
                        'Job' => false,
                        'BillWithParent' => false,
                        'Balance' => 0,
                        'BalanceWithJobs' => 0,
                        'CurrencyRef' => {
                          'value' => 'USD',
                          'name' => 'United States Dollar'
                        },
                        'PreferredDeliveryMethod' => 'Print',
                        'domain' => 'QBO',
                        'sparse' => false,
                        'SyncToken' => '0',
                        'MetaData' => {
                          'CreateTime' => '2019-07-11T13:04:17-07:00',
                          'LastUpdatedTime' => '2019-07-11T13:04:17-07:00'
                        },
                        'FullyQualifiedName' => 'Sample Customer',
                        'PrintOnCheckName' => 'Sample Customer',
                        'Active' => true,
                        'DefaultTaxCodeRef' => {
                          'value' => '2'
                        }
                      }
                    ]
                  ]
end
