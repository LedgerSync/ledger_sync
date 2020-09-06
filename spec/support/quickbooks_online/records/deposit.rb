# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Deposit
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Deposit',
          request_hash: {
            "Id": nil,
            "CurrencyRef": {
              "value": 'USD'
            },
            "TxnDate": '2019-09-01',
            "PrivateNote": 'Memo',
            "ExchangeRate": 1.0,
            "DepositToAccountRef": {
              "value": '123'
            },
            "DepartmentRef": {
              "value": '123'
            },
            "Line": [
              {
                "Id": nil,
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  },
                  "Entity": {
                    "value": '123',
                    "name": 'Sample Vendor',
                    "type": 'Vendor'
                  }
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 1'
              },
              {
                "Id": nil,
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  },
                  "Entity": nil
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 2'
              }
            ]
          },
          update_request_hash: {
            "Id": '123',
            "CurrencyRef": {
              "value": 'USD'
            },
            "TxnDate": '2019-09-01',
            "PrivateNote": 'Memo',
            "ExchangeRate": 1.0,
            "DepositToAccountRef": {
              "value": '123',
              "name": 'Cash on hand'
            },
            "DepartmentRef": {
              "value": '123',
              "name": 'Sample Department'
            },
            "Line": [
              {
                "Id": nil,
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  },
                  "Entity": {
                    "value": '123',
                    "name": 'Sample Vendor',
                    "type": 'Vendor'
                  }
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 1'
              },
              {
                "Id": nil,
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123'
                  },
                  "ClassRef": {
                    "value": '123'
                  },
                  "Entity": nil
                },
                "Amount": 123.45,
                "Description": 'Sample Transaction 2'
              }
            ],
            "TotalAmt": 246.9,
            "domain": 'QBO',
            "sparse": false,
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-10-11T11:54:50-07:00',
              "LastUpdatedTime": '2019-10-11T11:54:50-07:00'
            }
          },
          response_hash: {
            "DepositToAccountRef": {
              "value": '123',
              "name": 'Cash on hand'
            },
            "TotalAmt": 246.9,
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-10-11T11:54:50-07:00',
              "LastUpdatedTime": '2019-10-11T11:54:50-07:00'
            },
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
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Cash on hand'
                  },
                  "ClassRef": {
                    "value": '123',
                    "name": 'Sample Class'
                  }
                }
              },
              {
                "Id": '2',
                "LineNum": 2,
                "Description": 'Sample Transaction 2',
                "Amount": 123.45,
                "DetailType": 'DepositLineDetail',
                "DepositLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Cash on hand'
                  },
                  "ClassRef": {
                    "value": '123',
                    "name": 'Sample Class'
                  }
                }
              }
            ]
          }
        }
      end
    end
  end
end
