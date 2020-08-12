# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Transfer
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Transfer',
          request_hash: {
            "Id": nil,
            "Amount": 123.45,
            "PrivateNote": 'Memo',
            "FromAccountRef": {
              "value": '123'
            },
            "ToAccountRef": {
              "value": '123'
            },
            "TxnDate": '2019-09-01',
            "CurrencyRef": {
              "value": 'USD'
            }
          },
          update_request_hash: {
            "Id": '123',
            "Amount": 123.45,
            "PrivateNote": 'Memo',
            "FromAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "ToAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "TxnDate": '2019-09-01',
            "CurrencyRef": {
              "value": 'USD'
            },
            "domain": 'QBO',
            "sparse": false,
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-10-03T21:46:28-07:00',
              "LastUpdatedTime": '2019-10-03T21:46:28-07:00'
            }
          },
          response_hash: {
            "FromAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "ToAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "Amount": 123.45,
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '0',
            "MetaData": {
              "CreateTime": '2019-10-03T21:46:28-07:00',
              "LastUpdatedTime": '2019-10-03T21:46:28-07:00'
            },
            "TxnDate": '2019-09-01',
            "CurrencyRef": {
              "value": 'USD'
            },
            "PrivateNote": 'Memo'
          },
          search_url: ''
        }
      end
    end
  end
end
