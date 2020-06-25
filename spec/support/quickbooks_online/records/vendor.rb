# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Vendor
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Vendor',
          request_hash: {
            'Id' => nil,
            'DisplayName' => 'Sample Vendor',
            'GivenName' => 'Sample',
            'FamilyName' => 'Vendor',
            'PrimaryEmailAddr' => {
              'Address' => 'test@example.com'
            },
            'PrimaryPhone' => nil,
            'MiddleName' => nil,
            'CompanyName' => nil
          },
          update_request_hash: {
            "Id": '123',
            "DisplayName": 'Sample Vendor',
            "GivenName": 'Sample',
            "FamilyName": 'Vendor',
            "PrimaryEmailAddr": {
              "Address": 'test@example.com'
            },
            "Balance": 0,
            "Vendor1099": false,
            "CurrencyRef": {
              "value": 'USD'
            },
            "domain": 'QBO',
            "sparse": false,
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-09-12T09:03:28-07:00',
              "LastUpdatedTime": '2019-09-12T09:03:28-07:00'
            },
            "PrintOnCheckName": 'Sample Vendor',
            "Active": true,
            'PrimaryPhone' => nil,
            'MiddleName' => nil,
            'CompanyName' => nil

          },
          response_hash: {
            'Balance' => 0,
            'Vendor1099' => false,
            'CurrencyRef' => { 'value' => 'USD' },
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-09-12T09:03:28-07:00',
              'LastUpdatedTime' => '2019-09-12T09:03:28-07:00'
            },
            'GivenName' => 'Sample',
            'FamilyName' => 'Vendor',
            'DisplayName' => 'Sample Vendor',
            'PrintOnCheckName' => 'Sample Vendor',
            'Active' => true,
            'PrimaryEmailAddr' => {
              'Address' => 'test@example.com'
            } 
          },
          search_url: ""
        }
      end
    end
  end
end