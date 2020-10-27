# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Account
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Account',
          request_hash: {
            'Id' => nil,
            'Name' => 'Sample Account',
            'AccountType' => 'Bank',
            'AccountSubType' => 'CashOnHand',
            'AcctNum' => '123',
            'Classification' => 'Asset',
            'Description' => 'This is Sample Account',
            'Active' => true,
            'CurrencyRef' => {
              'value' => 'USD'
            }
          },
          update_request_hash: {
            "Name": 'Sample Account',
            "SubAccount": false,
            "FullyQualifiedName": 'Sample Account',
            "Active": true,
            "Classification": 'Asset',
            "AccountType": 'Bank',
            "AccountSubType": 'CashOnHand',
            'AcctNum' => '123',
            "CurrentBalance": 0,
            "CurrentBalanceWithSubAccounts": 0,
            "CurrencyRef": {
              "value": 'USD'
            },
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-09-12T12:22:16-07:00',
              "LastUpdatedTime": '2019-09-12T12:22:16-07:00'
            },
            "Description": 'This is Sample Account'
          },
          response_hash: {
            "Name": 'Sample Account',
            "SubAccount": false,
            "FullyQualifiedName": 'Sample Account',
            "Active": true,
            "Classification": 'Asset',
            "AccountType": 'Bank',
            "AccountSubType": 'CashOnHand',
            "AcctNum": '123',
            "CurrentBalance": 0,
            "CurrentBalanceWithSubAccounts": 0,
            "CurrencyRef": {
              "value": 'USD'
            },
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-09-12T12:22:16-07:00',
              "LastUpdatedTime": '2019-09-12T12:22:16-07:00'
            }
          },
          search_url: "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Account%20WHERE'%20Name%20LIKE%20'%25Sample%20Account%25'%20STARTPOSITION%201%20MAXRESULTS%2010"
        }
      end
    end
  end
end
