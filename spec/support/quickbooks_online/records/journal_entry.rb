# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class JournalEntry
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'JournalEntry',
          request_hash: {
            'Id' => nil,
            'CurrencyRef' => { 'value' => 'USD' },
            'TxnDate' => '2019-09-01',
            'PrivateNote' => 'Memo',
            'DocNumber' => 'Ref123',
            'Line' => [
              {
                'DetailType' => 'JournalEntryLineDetail',
                'Amount' => 123.45,
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Credit',
                  'AccountRef' => { 'value' => '123' },
                  'ClassRef' => { 'value' => '123' },
                  'DepartmentRef' => { 'value' => '123' }
                },
                'Description' => 'Sample Transaction'
              },
              {
                'DetailType' => 'JournalEntryLineDetail',
                'Amount' => 123.45,
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123' },
                  'ClassRef' => { 'value' => '123' },
                  'DepartmentRef' => { 'value' => '123' }
                },
                'Description' => 'Sample Transaction'
              }
            ]
          },
          update_request_hash: {
            'Adjustment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-10-13T13:28:14-07:00',
              'LastUpdatedTime' => '2019-10-13T13:28:14-07:00'
            },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => {
              'value' => 'USD',
              'name' => 'United States Dollar'
            },
            'PrivateNote' => 'Memo',
            'Line' => [
              {
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Credit',
                  'AccountRef' => { 'value' => '123' },
                  'ClassRef' => { 'value' => '123' },
                  'DepartmentRef' => { 'value' => '123' }
                },
                'Amount' => 123.45,
                'Description' => 'Sample Transaction'
              },
              {
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123' },
                  'ClassRef' => { 'value' => '123' },
                  'DepartmentRef' => { 'value' => '123' }
                },
                'Amount' => 123.45,
                'Description' => 'Sample Transaction'
              }
            ]
          },
          response_hash: {
            'Adjustment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-10-13T13:28:14-07:00',
              'LastUpdatedTime' => '2019-10-13T13:28:14-07:00'
            },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => {
              'value' => 'USD',
              'name' => 'United States Dollar'
            },
            'PrivateNote' => 'Memo',
            'Line' => [
              {
                'Id' => '0',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Credit',
                  'AccountRef' => { 'value' => '123', 'name' => 'Cash on hand' },
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' }
                }
              },
              {
                'Id' => '1',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' => {
                  'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' }
                }
              }
            ]
          }
        }
      end
    end
  end
end
