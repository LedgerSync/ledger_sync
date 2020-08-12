# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Invoice
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Invoice',
          request_hash: {
            'Id' => nil,
            'CurrencyRef' => { 'value' => 'USD' },
            'TxnDate' => '2019-09-01',
            'PrivateNote' => 'Memo 1',
            'CustomerRef' => { 'value' => '123' },
            'DepositToAccountRef' => { 'value' => '123' },
            'Line' => [
              {
                'Id' => nil,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' => {
                  'ItemRef' => { 'value' => '123' },
                  'ClassRef' => nil
                },
                'Amount' => 1.0,
                'Description' => 'Sample Description'
              }
            ]
          },
          update_request_hash: {
            'Id' => '123',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'TxnDate' => '2019-09-01',
            'PrivateNote' => 'Memo 1',
            'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
            'DepositToAccountRef' => { 'value' => '123' },
            'Line' => [
              {
                'Id' => nil,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' => {
                  'ItemRef' => { 'value' => '123' },
                  'ClassRef' => nil
                },
                'Amount' => 1.0,
                'Description' => 'Sample Description'
              }
            ],
            'Deposit' => 0,
            'AllowIPNPayment' => false,
            'AllowOnlinePayment' => false,
            'AllowOnlineCreditCardPayment' => false,
            'AllowOnlineACHPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2020-01-15T06:25:44-08:00',
              'LastUpdatedTime' => '2020-01-15T06:25:44-08:00'
            },
            'CustomField' => [
              { 'DefinitionId' => '1', 'Type' => 'StringType' }
            ],
            'DocNumber' => '1040',
            'LinkedTxn' => [],
            'DueDate' => '2019-09-01',
            'TotalAmt' => 1.5,
            'ApplyTaxAfterDiscount' => false,
            'PrintStatus' => 'NeedToPrint',
            'EmailStatus' => 'NotSet',
            'Balance' => 1.5
          },
          response_hash: {
            'Deposit' => 0,
            'AllowIPNPayment' => false,
            'AllowOnlinePayment' => false,
            'AllowOnlineCreditCardPayment' => false,
            'AllowOnlineACHPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '173',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2020-01-15T06:25:44-08:00',
              'LastUpdatedTime' => '2020-01-15T06:25:44-08:00'
            },
            'CustomField' => [
              { 'DefinitionId' => '1', 'Type' => 'StringType' }
            ],
            'DocNumber' => '1040',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo 1',
            'LinkedTxn' => [],
            'Line' => [
              {
                'Id' => '1',
                'LineNum' => 1,
                'Description' => 'Test Item',
                'Amount' => 1.5,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' => {
                  'ItemRef' => { 'value' => '33', 'name' => 'Services' },
                  'TaxCodeRef' => { 'value' => 'NON' }
                }
              },
              {
                'Amount' => 1.5,
                'DetailType' => 'SubTotalLineDetail',
                'SubTotalLineDetail' => {}
              }
            ],
            'CustomerRef' => { 'value' => '83', 'name' => 'Lola' },
            'DueDate' => '2019-09-01',
            'TotalAmt' => 1.5,
            'ApplyTaxAfterDiscount' => false,
            'PrintStatus' => 'NeedToPrint',
            'EmailStatus' => 'NotSet',
            'Balance' => 1.5
          }
        }
      end
    end
  end
end
