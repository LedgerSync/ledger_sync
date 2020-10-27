# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Payment
      def self.stub
        {
          ledger_id: '123',
          ledger_class: name.demodulize,
          ledger_resource: 'Payment',
          request_hash: {
            'Id' => nil,
            'TotalAmt' => 123.45,
            'CurrencyRef' => { 'value' => 'USD' },
            'CustomerRef' => { 'value' => '123' },
            'DepositToAccountRef' => { 'value' => '123' },
            'ARAccountRef' => { 'value' => '123' },
            'PaymentRefNum' => 'Ref123',
            'PrivateNote' => 'Memo',
            'ExchangeRate' => 1.0,
            'TxnDate' => '2019-09-01',
            'Line' => [
              {
                'Amount' => 1.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ]
              }
            ]
          },
          update_request_hash: {
            'Id' => '123',
            'TotalAmt' => 123.45,
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
            'DepositToAccountRef' => { 'value' => '123' },
            'ARAccountRef' => { 'value' => '123' },
            'PaymentRefNum' => 'Ref123',
            'PrivateNote' => 'Memo',
            'ExchangeRate' => 1.0,
            'TxnDate' => '2019-09-01',
            'Line' => [
              {
                'Amount' => 1.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ]
              }
            ],
            'PaymentMethodRef' => { 'value' => '29' },
            'UnappliedAmt' => 0,
            'ProcessPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-12-03T10:14:03-08:00',
              'LastUpdatedTime' => '2019-12-03T10:14:03-08:00'
            }
          },
          response_hash: {
            'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
            'DepositToAccountRef' => { 'value' => '123' },
            'PaymentMethodRef' => { 'value' => '29' },
            'PaymentRefNum' => '123',
            'TotalAmt' => 100.0,
            'UnappliedAmt' => 0,
            'ProcessPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' => {
              'CreateTime' => '2019-12-03T10:14:03-08:00',
              'LastUpdatedTime' => '2019-12-03T10:14:03-08:00'
            },
            'TxnDate' => '2019-12-03',
            'CurrencyRef' => {
              'value' => 'USD',
              'name' => 'United States Dollar'
            },
            'Line' => [
              {
                'Amount' => 100.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ],
                'LineEx' => {
                  'any' => [
                    {
                      'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                      'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                      'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                      'value' => { 'Name' => 'txnId', 'Value' => '123' },
                      'nil' => false,
                      'globalScope' => true,
                      'typeSubstituted' => false
                    },
                    {
                      'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                      'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                      'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                      'value' => { 'Name' => 'txnOpenBalance', 'Value' => '100.00' },
                      'nil' => false,
                      'globalScope' => true,
                      'typeSubstituted' => false
                    },
                    {
                      'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                      'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                      'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                      'value' => { 'Name' => 'txnReferenceNumber', 'Value' => '1038' },
                      'nil' => false,
                      'globalScope' => true,
                      'typeSubstituted' => false
                    }
                  ]
                }
              }
            ]
          },
          search_url: ''
        }
      end
    end
  end
end
