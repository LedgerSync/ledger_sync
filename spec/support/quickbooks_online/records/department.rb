# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Department
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Department',
          request_hash: {
            'Id' => nil,
            'Name' => 'Test Department',
            'Active' => true,
            'SubDepartment' => false,
            'FullyQualifiedName' => nil,
            'ParentRef' => nil
          },
          update_request_hash: {
            'Id' => '123',
            'Name' => 'Test Department',
            'Active' => true,
            'SubDepartment' => false,
            'FullyQualifiedName' => nil,
            'ParentRef' => nil,
            'domain' => 'QBO',
            'sparse' => false,
            'SyncToken' => '0',
            'MetaData' =>
             {
               'CreateTime' => '2019-12-04T14:24:59-08:00',
               'LastUpdatedTime' => '2019-12-04T14:24:59-08:00'
             }
          },
          response_hash: {
            'Name' => 'Test Department',
            'SubDepartment' => true,
            'ParentRef' => { 'value' => nil },
            'FullyQualifiedName' => 'Test Department',
            'Active' => true,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-12-04T14:24:59-08:00',
              'LastUpdatedTime' => '2019-12-04T14:24:59-08:00'
            }
          },
          search_url: "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Department%20WHERE%20Name%20LIKE%20'%25Test%20Department%25'%20STARTPOSITION%201%20MAXRESULTS%2010"
        }
      end
    end
  end
end