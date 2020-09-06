# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Expense
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Purchase',
          request_hash: {
            "Id": nil,
            "CurrencyRef": {
              "value": 'USD'
            },
            "PaymentType": 'Cash',
            "TxnDate": '2019-09-01',
            "PrivateNote": 'Memo',
            "ExchangeRate": 1.0,
            "EntityRef": {
              "value": '123',
              "name": 'Sample Vendor',
              "type": 'Vendor'
            },
            "DocNumber": 'Ref123',
            "AccountRef": {
              "value": '123'
            },
            "DepartmentRef": {
              "value": '123'
            },
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
            "Id": '123',
            "CurrencyRef": {
              "value": 'USD'
            },
            "PaymentType": 'Cash',
            "TxnDate": '2019-09-01',
            "PrivateNote": 'Memo',
            "ExchangeRate": 1.0,
            "EntityRef": {
              "value": '123',
              "name": 'Sample Vendor',
              "type": 'Vendor'
            },
            "DocNumber": 'Ref123',
            "AccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "DepartmentRef": {
              "value": '123',
              "name": 'Sample Department'
            },
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
            ],
            "TotalAmt": 24_690.0,
            "PurchaseEx": {
              "any": [
                {
                  "name": '{http://schema.intuit.com/finance/v3}NameValue',
                  "declaredType": 'com.intuit.schema.finance.v3.NameValue',
                  "scope": 'javax.xml.bind.JAXBElement$GlobalScope',
                  "value": {
                    "Name": 'TxnType',
                    "Value": '54'
                  },
                  "nil": false,
                  "globalScope": true,
                  "typeSubstituted": false
                }
              ]
            },
            "domain": 'QBO',
            "sparse": false,
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-09-20T09:44:50-07:00',
              "LastUpdatedTime": '2019-09-20T09:44:50-07:00'
            },
            "CustomField": []
          },
          response_hash: {
            "AccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "PaymentType": 'Cash',
            "EntityRef": {
              "value": '123',
              "name": 'Sample Vendor',
              "type": 'Vendor'
            },
            "TotalAmt": 24_690.0,
            "PurchaseEx": {
              "any": [
                {
                  "name": '{http://schema.intuit.com/finance/v3}NameValue',
                  "declaredType": 'com.intuit.schema.finance.v3.NameValue',
                  "scope": 'javax.xml.bind.JAXBElement$GlobalScope',
                  "value": {
                    "Name": 'TxnType',
                    "Value": '54'
                  },
                  "nil": false,
                  "globalScope": true,
                  "typeSubstituted": false
                }
              ]
            },
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-09-20T09:44:50-07:00',
              "LastUpdatedTime": '2019-09-20T09:44:50-07:00'
            },
            "CustomField": [],
            "DocNumber": 'Ref123',
            "DepartmentRef": {
              "value": '123',
              "name": 'Sample Department'
            },
            "TxnDate": '2019-09-01',
            "CurrencyRef": {
              "value": 'USD'
            },
            "PrivateNote": 'Memo',
            "Line": [
              {
                "Id": '1',
                "Description": 'Sample Transaction 1',
                "Amount": 123.45,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Sample Account'
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
                "Description": 'Sample Transaction 2',
                "Amount": 123.45,
                "DetailType": 'AccountBasedExpenseLineDetail',
                "AccountBasedExpenseLineDetail": {
                  "AccountRef": {
                    "value": '123',
                    "name": 'Sample Account'
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
            ]
          }
        }
      end
    end
  end
end
