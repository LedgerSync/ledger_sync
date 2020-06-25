# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class LedgerClass
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Class',
          request_hash: {
            'Id' => nil,
            'Name' => 'Test Class',
            'Active' => true,
            'SubClass' => false,
            'FullyQualifiedName' => nil,
            'ParentRef' => nil
          },
          update_request_hash: {
            'Id' => '123',
            'Name' => 'Test Class',
            'Active' => true,
            'SubClass' => false,
            'FullyQualifiedName' => nil,
            'ParentRef' => nil,
            'domain' => 'QBO',
            'sparse' => false,
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-12-04T08:34:10-08:00',
             'LastUpdatedTime' => '2019-12-04T08:34:10-08:00'
            }
          },
          response_hash: {
            'Name' => 'Test Class',
            'SubClass' => false,
            'FullyQualifiedName' => 'Test Class',
            'Active' => true,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '5000000000000137302',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-12-04T08:34:10-08:00',
              'LastUpdatedTime' => '2019-12-04T08:34:10-08:00'
            } 
          },
          search_url: "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Class%20WHERE%20'Name%20LIKE%20'%25Test%20Class%25'%20STARTPOSITION%201%20MAXRESULTS%2010"
        }
      end
    end
  end
end