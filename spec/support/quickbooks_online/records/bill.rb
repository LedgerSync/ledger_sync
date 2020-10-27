# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Bill
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Bill',
          request_hash: {
            "Id": nil,
            "CurrencyRef": {
              "value": 'USD'
            },
            "DueDate": '2019-09-01',
            "PrivateNote": 'Memo',
            "TxnDate": '2019-09-01',
            "VendorRef": {
              "value": '123'
            },
            "APAccountRef": {
              "value": '123'
            },
            "DepartmentRef": {
              "value": '123'
            },
            "DocNumber": 'Ref123',
            "Line": [
              {
                "Id": nil,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  }
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 1'
              },
              {
                "Id": nil,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  }
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 2'
              }
            ]
          },
          update_request_hash: {
            'Id' => '123',
            'CurrencyRef' => {
              'value' => 'USD'
            },
            'DueDate' => '2019-09-01',
            'PrivateNote' => 'Memo',
            'TxnDate' => '2019-09-01',
            'VendorRef' => {
              'value' => '123',
              'name' => 'Sample Vendor'
            },
            'APAccountRef' => {
              'value' => '123',
              'name' => 'Accounts Payable (A/P)'
            },
            'DepartmentRef' => {
              'value' => '123',
              'name' => 'Sample Department'
            },
            'DocNumber' => 'Ref123',
            'Line' =>
             [
               {
                 'Id' => nil,
                 'DetailType' => 'AccountBasedExpenseLineDetail',
                 'AccountBasedExpenseLineDetail' =>
                {
                  'AccountRef' => {
                    'value' => '123'
                  }, 'ClassRef' => {
                    'value' => '123'
                  }
                },
                 'Amount' => 123.45,
                 'Description' => 'Sample Transaction 1'
               },
               {
                 'Id' => nil,
                 'DetailType' => 'AccountBasedExpenseLineDetail',
                 'AccountBasedExpenseLineDetail' =>
                 {
                   'AccountRef' => {
                     'value' => '123'
                   }, 'ClassRef' => {
                     'value' => '123'
                   }
                 },
                 'Amount' => 123.45,
                 'Description' => 'Sample Transaction 2'
               }
             ],
            'Balance' => 246.9,
            'domain' => 'QBO',
            'sparse' => false,
            'SyncToken' => '0',
            'MetaData' =>
             {
               'CreateTime' => '2019-10-13T10:43:04-07:00',
               'LastUpdatedTime' => '2019-10-13T10:43:04-07:00'
             },
            'TotalAmt' => 246.9
          },
          response_hash: {
            "DueDate": '2019-09-01',
            "Balance": 246.9,
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-10-13T10:43:04-07:00',
              "LastUpdatedTime": '2019-10-13T10:43:04-07:00'
            },
            "DocNumber": 'Ref123',
            "TxnDate": '2019-09-01',
            "DepartmentRef": {
              "value": '123',
              "name": 'Sample Department'
            },
            "CurrencyRef": {
              "value": 'USD'
            },
            "PrivateNote": 'Memo',
            "Line": [
              {
                "Id": '1',
                "LineNum": 1,
                "Description": 'Sample Transaction 1',
                "Amount": 123.45,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Opening Balance Equity'
                  },
                  "BillableStatus": 'NotBillable',
                  "ClassRef": {
                    "value": '123',
                    "name": 'Sample Class'
                  },
                  "TaxCodeRef": {
                    "value": 'NON'
                  }
                }
              },
              {
                "Id": '2',
                "LineNum": 2,
                "Description": 'Sample Transaction 2',
                "Amount": 123.45,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Opening Balance Equity'
                  },
                  "BillableStatus": 'NotBillable',
                  "ClassRef": {
                    "value": '123',
                    "name": 'Sample Class'
                  },
                  "TaxCodeRef": {
                    "value": 'NON'
                  }
                }
              }
            ],
            "VendorRef": {
              "value": '123',
              "name": 'Sample Vendor'
            },
            "APAccountRef": {
              "value": '123',
              "name": 'Accounts Payable (A/P)'
            },
            "TotalAmt": 246.9
          },
          search_url: ''
        }
      end
    end
  end
end
