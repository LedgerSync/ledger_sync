# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class BillPayment
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'BillPayment',
          request_hash: {
            'Id' => nil,
            'TotalAmt' => 1.0,
            'CurrencyRef' => { 'value' => 'USD' },
            'VendorRef' => { 'value' => '123' },
            'DepartmentRef' => { 'value' => '123' },
            'APAccountRef' => { 'value' => '123' },
            'DocNumber' => 'Ref123',
            'PrivateNote' => 'Note',
            'ExchangeRate' => 1.0,
            'TxnDate' => '2019-09-01',
            'PayType' => 'CreditCard',
            'CreditCardPayment' => {
              'CCAccountRef' => { 'value' => '123' }
            },
            'CheckPayment' => nil,
            'Line' => [
              {
                'Amount' => 1.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Bill' }
                ]
              }
            ]
          },
          response_hash: {
            'VendorRef' => { 'value' => '123', 'name' => 'Vendor 123' },
            'PayType' => 'CreditCard',
            'CreditCardPayment' => {
              'CCAccountRef' => { 'value' => '123', 'name' => 'Credit Card' }
            },
            'CheckPayment' => nil,
            'TotalAmt' => 1.0,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'DepartmentRef' => { 'value' => '123', 'name' => 'Main Department' },
            'APAccountRef' => { 'value' => '123', 'name' => 'Account' },
            'DocNumber' => 'Ref123',
            'PrivateNote' => 'Note',
            'MetaData' => {
              'CreateTime' => '2020-02-05T09:49:13-08:00',
              'LastUpdatedTime' => '2020-02-05T09:49:13-08:00'
            },
            'ExchangeRate' => 1.0,
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'Line' => [
              {
                'Amount' => 1.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Bill' }
                ]
              }
            ]
          },
          search_url: ''
        }
      end
    end
  end
end
