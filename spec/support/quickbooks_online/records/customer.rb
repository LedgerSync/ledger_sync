# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Customer
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Customer',
          request_hash: {
            'Id' => nil,
            'DisplayName' => 'Sample Customer',
            'PrimaryPhone' => nil,
            'GivenName' => nil,
            'FamilyName' => nil,
            'MiddleName' => nil,
            'PrimaryEmailAddr' => {
              'Address' => 'test@example.com'
            }
          },
          update_request_hash: {
            'Id' => '123',
            "DisplayName"=>"Sample Customer",
            "GivenName"=>nil,
            "FamilyName"=>nil,
            "MiddleName"=>nil,
            "PrimaryPhone"=>nil,
            "PrimaryEmailAddr"=>{"Address"=>"test@example.com"},
            "Taxable"=>true,
            "Job"=>false,
            "BillWithParent"=>false,
            "Balance"=>0,
            "BalanceWithJobs"=>0,
            "CurrencyRef"=>{"value"=>"USD", "name"=>"United States Dollar"},
            "PreferredDeliveryMethod"=>"Print",
            "domain"=>"QBO",
            "sparse"=>false,
            "SyncToken"=>"0",
            "MetaData"=>{"CreateTime"=>"2019-07-11T13:04:17-07:00", "LastUpdatedTime"=>"2019-07-11T13:04:17-07:00"},
            "FullyQualifiedName"=>"Sample Customer",
            "PrintOnCheckName"=>"Sample Customer",
            "Active"=>true,
            "DefaultTaxCodeRef"=>{"value"=>"2"}
          },
          response_hash: {
            'Taxable' => true,
            'Job' => false,
            'BillWithParent' => false,
            'Balance' => 0,
            'BalanceWithJobs' => 0,
            'CurrencyRef' => {
              'value' => 'USD', 'name' => 'United States Dollar'
            },
            'PreferredDeliveryMethod' => 'Print',
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' =>
              {
                'CreateTime' => '2019-07-11T13:04:17-07:00',
                'LastUpdatedTime' => '2019-07-11T13:04:17-07:00'
              },
            'FullyQualifiedName' => 'Sample Customer',
            'DisplayName' => 'Sample Customer',
            'PrintOnCheckName' => 'Sample Customer',
            'Active' => true,
            'PrimaryEmailAddr' => {
              'Address' => 'test@example.com'
            },
            'PrimaryPhone' => nil,
            'DefaultTaxCodeRef' => {
              'value' => '2'
            }
          },
          search_url: "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20'Customer%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Customer%25'%20STARTPOSITION%201%20MAXRESULTS%2010"
        }
      end
    end
  end
end