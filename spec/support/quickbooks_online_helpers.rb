# frozen_string_literal: true

require_relative 'quickbooks_online/record_collection'

module QuickBooksOnlineHelpers # rubocop:disable Metrics/ModuleLength
  def api_url(ledger_id: nil, record:)
    resource_class = "LedgerSync::Ledgers::QuickBooksOnline::#{record.ledger_class}".constantize
    url_resource = LedgerSync::Ledgers::QuickBooksOnline::Client.ledger_resource_type_for(
      resource_class: resource_class
     )
    ret = "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/#{url_resource}"
    if url_resource.to_s == 'preferences'
      ret += '/' unless ret.end_with?('/')
    end
    if ledger_id
      ret += '/' unless ret.end_with?('/')
      ret += ledger_id.to_s
    end
    ret
  end

  def headers
    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => 'Bearer access_token',
      'Content-Type' => 'application/json',
      'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/

    }
  end

  def stub_create(request_body:, response_body:, url:)
    stub_request(:post, url)
      .with(
        body: request_body,
        headers: headers
      )
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_json)
      )
  end

  def stub_find(response_body:, url:)
    stub_request(:get, url)
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_json)
      )
  end

  def stub_search(response_body:, url:)
    stub_request(:get, url)
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_json)
      )
  end

  def stub_update(request_body:, response_body:, url:)
    stub_request(:post, url)
      .with(
        body: request_body,
        headers: headers
      )
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_json)
      )
  end

  Test::QuickBooksOnline::RecordCollection.new.all.each do |resource, record|
    request_body_hash = "#{resource}_request_body_hash"
    response_body_hash = "#{resource}_response_body_hash"
    search_response_body_hash = "#{resource}_search_response_body_hash"
    stub_create_method = "stub_#{resource}_create"
    stub_find_method = "stub_#{resource}_find"
    stub_delete_method = "stub_#{resource}_delete"
    stub_update_method = "stub_#{resource}_update"
    stub_search_method = "stub_#{resource}_search"

    define_method(request_body_hash) do
      record.try(:request_hash)
    end

    define_method(response_body_hash) do
      {
        record.try(:ledger_resource).to_s =>
        record.try(:response_hash)

      }
    end

    define_method(search_response_body_hash) do
      {
        'QueryResponse' => {
          record.try(:ledger_resource).to_s => [
            record.try(:response_hash)
          ]
        }

      }
    end

    define_method(stub_create_method) do |request_body: nil, response_body: nil|
      stub_create(
        request_body: (request_body || send(request_body_hash)),
        response_body: (response_body || send(response_body_hash)),
        url: api_url(record: record)
      )
    end

    define_method(stub_find_method) do |ledger_id: nil, response_body: nil|
      stub_find(
        response_body: (response_body || send(response_body_hash)),
        url: api_url(
          ledger_id: (ledger_id || record.try(:ledger_id)),
          record: record
        )
      )
    end

    define_method(stub_delete_method) do |request_body: nil, response_body: nil|
    end

    define_method(stub_update_method) do |request_body: nil, response_body: nil|
      stub_update(
        request_body: (
          request_body ||
          record.try(:update_request_hash) ||
          record.try(:response_hash) # This defaults to response body because FullUpdates are required
        ),
        response_body: (response_body || send(response_body_hash)),
        url: api_url(record: record)
      )
    end

    define_method(stub_search_method) do |response_body: nil, url: nil|
      stub_search(
        response_body: (response_body || send(search_response_body_hash)),
        url: (url || record.try(:search_url))
      )
    end
  end

  # Ledger
  def quickbooks_online_client
    LedgerSync.ledgers.quickbooks_online.new(
      access_token: 'access_token',
      client_id: 'client_id',
      client_secret: 'client_secret',
      realm_id: 'realm_id',
      refresh_token: 'refresh_token',
      test: true
    )
  end

  def basic_authorization_header
    'Basic ' + Base64.strict_encode64(client_id + ':' + client_secret)
  end

  def stub_client_refresh
    stub_request(:post, 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer')
      .with(
        body: {
          'client_id' => 'client_id',
          'client_secret' => 'client_secret',
          'grant_type' => 'refresh_token',
          'refresh_token' => 'refresh_token'
        },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'token_type' => 'bearer',
                'expires_in' => 3600,
                'refresh_token' => 'NEW_REFRESH_TOKEN',
                'x_refresh_token_expires_in' => 1_569_480_516,
                'access_token' => 'NEW_ACCESS_TOKEN' }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
  end

  def stub_revoke_token
    stub_request(
      :post,
      'https://developer.api.intuit.com/v2/oauth2/tokens/revoke'
    ).with(
      body: {
        'token' => 'access_token'

      }.to_json,
      headers: {
        'Accept' => 'application/json',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => basic_authorization_header,
        'Content-Type' => 'application/json',
        'User-Agent' => 'Ruby'

      }
    ).to_return(
      status: 200,
      body: '',
      headers: {}
    )
  end

  #####

  def stub_create_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: { 'Id' => nil,
                'TotalAmt' => 123.45,
                'CurrencyRef' => { 'value' => 'USD' },
                'CustomerRef' => { 'value' => '123' },
                'DepositToAccountRef' => { 'value' => '123' },
                'ARAccountRef' => { 'value' => '123' },
                'PaymentRefNum' => 'Ref123',
                'PrivateNote' => 'Memo',
                'ExchangeRate' => 1.0,
                'TxnDate' => '2019-09-01',
                'Line' =>
           [
             { 'Amount' => 1.0, 'LinkedTxn' => [
               { 'TxnId' => '123', 'TxnType' => 'Invoice' }
             ] }
           ] },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Payment' =>
          { 'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
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
            'MetaData' =>
            { 'CreateTime' => '2019-12-03T10:14:03-08:00',
              'LastUpdatedTime' => '2019-12-03T10:14:03-08:00' },
            'TxnDate' => '2019-12-03',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'Line' =>
            [
              { 'Amount' => 100.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ],
                'LineEx' =>
               { 'any' =>
                 [
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnId', 'Value' => '123' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnOpenBalance', 'Value' => '100.00' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnReferenceNumber', 'Value' => '1038' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false }
                 ] } }
            ] },
                'time' => '2019-12-23T06:51:43.325-08:00' }.to_json,
        headers: {}
      )
  end

  def stub_find_payment
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Payment' =>
          { 'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
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
            'MetaData' =>
            { 'CreateTime' => '2019-12-03T10:14:03-08:00',
              'LastUpdatedTime' => '2019-12-03T10:14:03-08:00' },
            'TxnDate' => '2019-12-03',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'Line' =>
            [
              { 'Amount' => 100.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ],
                'LineEx' =>
               { 'any' =>
                 [
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnId', 'Value' => '123' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnOpenBalance', 'Value' => '100.00' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnReferenceNumber', 'Value' => '1038' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false }
                 ] } }
            ] },
                'time' => '2019-12-23T06:51:43.325-08:00' }.to_json,
        headers: {}
      )
  end

  def stub_update_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: { 'Id' => '123',
                'TotalAmt' => 123.45,
                'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
                'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
                'DepositToAccountRef' => { 'value' => '123' },
                'ARAccountRef' => { 'value' => '123' },
                'PaymentRefNum' => 'Ref123',
                'PrivateNote' => 'Memo',
                'ExchangeRate' => 1.0,
                'TxnDate' => '2019-09-01',
                'Line' =>
           [
             { 'Amount' => 1.0, 'LinkedTxn' => [
               { 'TxnId' => '123', 'TxnType' => 'Invoice' }
             ] }
           ],
                'PaymentMethodRef' => { 'value' => '29' },
                'UnappliedAmt' => 0,
                'ProcessPayment' => false,
                'domain' => 'QBO',
                'sparse' => false,
                'SyncToken' => '0',
                'MetaData' =>
           { 'CreateTime' => '2019-12-03T10:14:03-08:00',
             'LastUpdatedTime' => '2019-12-03T10:14:03-08:00' } },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Payment' =>
          { 'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
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
            'MetaData' =>
            { 'CreateTime' => '2019-12-03T10:14:03-08:00',
              'LastUpdatedTime' => '2019-12-03T10:14:03-08:00' },
            'TxnDate' => '2019-12-03',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'Line' =>
            [
              { 'Amount' => 100.0,
                'LinkedTxn' => [
                  { 'TxnId' => '123', 'TxnType' => 'Invoice' }
                ],
                'LineEx' =>
               { 'any' =>
                 [
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnId', 'Value' => '123' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnOpenBalance', 'Value' => '100.00' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false },
                   { 'name' => '{http://schema.intuit.com/finance/v3}NameValue',
                     'declaredType' => 'com.intuit.schema.finance.v3.NameValue',
                     'scope' => 'javax.xml.bind.JAXBElement$GlobalScope',
                     'value' => { 'Name' => 'txnReferenceNumber', 'Value' => '1038' },
                     'nil' => false,
                     'globalScope' => true,
                     'typeSubstituted' => false }
                 ] } }
            ] },
                'time' => '2019-12-23T06:51:43.325-08:00' }.to_json,
        headers: {}
      )
  end

  # Invoice
  def stub_create_invoice
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice')
      .with(
        body: { 'Id' => nil,
                'CurrencyRef' => { 'value' => 'USD' },
                'TxnDate' => '2019-09-01',
                'PrivateNote' => 'Memo 1',
                'CustomerRef' => { 'value' => '123' },
                'DepositToAccountRef' => { 'value' => '123' },
                'Line' =>
           [
             { 'Id' => nil,
               'DetailType' => 'SalesItemLineDetail',
               'SalesItemLineDetail' =>
              { 'ItemRef' => { 'value' => '123' }, 'ClassRef' => { 'value' => nil } },
               'Amount' => 1.0,
               'Description' => 'Sample Description' }
           ] },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Invoice' =>
          { 'Deposit' => 0,
            'AllowIPNPayment' => false,
            'AllowOnlinePayment' => false,
            'AllowOnlineCreditCardPayment' => false,
            'AllowOnlineACHPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '173',
            'SyncToken' => '0',
            'MetaData' =>
            { 'CreateTime' => '2020-01-15T06:25:44-08:00',
              'LastUpdatedTime' => '2020-01-15T06:25:44-08:00' },
            'CustomField' => [
              { 'DefinitionId' => '1', 'Type' => 'StringType' }
            ],
            'DocNumber' => '1040',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo 1',
            'LinkedTxn' => [],
            'Line' =>
            [
              { 'Id' => '1',
                'LineNum' => 1,
                'Description' => 'Test Item',
                'Amount' => 1.5,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' =>
               { 'ItemRef' => { 'value' => '33', 'name' => 'Services' },
                 'TaxCodeRef' => { 'value' => 'NON' } } },
              { 'Amount' => 1.5,
                'DetailType' => 'SubTotalLineDetail',
                'SubTotalLineDetail' => {} }
            ],
            'CustomerRef' => { 'value' => '83', 'name' => 'Lola' },
            'DueDate' => '2019-09-01',
            'TotalAmt' => 1.5,
            'ApplyTaxAfterDiscount' => false,
            'PrintStatus' => 'NeedToPrint',
            'EmailStatus' => 'NotSet',
            'Balance' => 1.5 },
                'time' => '2020-01-15T06:25:44.543-08:00' }.to_json,
        headers: {}
      )
  end

  def stub_find_invoice
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Invoice' =>
          { 'Deposit' => 0,
            'AllowIPNPayment' => false,
            'AllowOnlinePayment' => false,
            'AllowOnlineCreditCardPayment' => false,
            'AllowOnlineACHPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '173',
            'SyncToken' => '0',
            'MetaData' =>
            { 'CreateTime' => '2020-01-15T06:25:44-08:00',
              'LastUpdatedTime' => '2020-01-15T06:25:44-08:00' },
            'CustomField' => [
              { 'DefinitionId' => '1', 'Type' => 'StringType' }
            ],
            'DocNumber' => '1040',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo 1',
            'LinkedTxn' => [],
            'Line' =>
            [
              { 'Id' => '1',
                'LineNum' => 1,
                'Description' => 'Test Item',
                'Amount' => 1.5,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' =>
               { 'ItemRef' => { 'value' => '33', 'name' => 'Services' },
                 'TaxCodeRef' => { 'value' => 'NON' } } },
              { 'Amount' => 1.5,
                'DetailType' => 'SubTotalLineDetail',
                'SubTotalLineDetail' => {} }
            ],
            'CustomerRef' => { 'value' => '83', 'name' => 'Lola' },
            'DueDate' => '2019-09-01',
            'TotalAmt' => 1.5,
            'ApplyTaxAfterDiscount' => false,
            'PrintStatus' => 'NeedToPrint',
            'EmailStatus' => 'NotSet',
            'Balance' => 1.5 },
                'time' => '2020-01-15T06:25:44.543-08:00' }.to_json,
        headers: {}
      )
  end

  def stub_update_invoice
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice')
      .with(
        body: { 'Id' => '123',
                'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
                'TxnDate' => '2019-09-01',
                'PrivateNote' => 'Memo 1',
                'CustomerRef' => { 'value' => '123', 'name' => 'Lola' },
                'DepositToAccountRef' => { 'value' => '123' },
                'Line' =>
           [
             { 'Id' => nil,
               'DetailType' => 'SalesItemLineDetail',
               'SalesItemLineDetail' =>
              { 'ItemRef' => { 'value' => '123' }, 'ClassRef' => { 'value' => nil } },
               'Amount' => 1.0,
               'Description' => 'Sample Description' }
           ],
                'Deposit' => 0,
                'AllowIPNPayment' => false,
                'AllowOnlinePayment' => false,
                'AllowOnlineCreditCardPayment' => false,
                'AllowOnlineACHPayment' => false,
                'domain' => 'QBO',
                'sparse' => false,
                'SyncToken' => '0',
                'MetaData' =>
           { 'CreateTime' => '2020-01-15T06:25:44-08:00',
             'LastUpdatedTime' => '2020-01-15T06:25:44-08:00' },
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
                'Balance' => 1.5 },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Invoice' =>
          { 'Deposit' => 0,
            'AllowIPNPayment' => false,
            'AllowOnlinePayment' => false,
            'AllowOnlineCreditCardPayment' => false,
            'AllowOnlineACHPayment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '173',
            'SyncToken' => '0',
            'MetaData' =>
            { 'CreateTime' => '2020-01-15T06:25:44-08:00',
              'LastUpdatedTime' => '2020-01-15T06:25:44-08:00' },
            'CustomField' => [
              { 'DefinitionId' => '1', 'Type' => 'StringType' }
            ],
            'DocNumber' => '1040',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo 1',
            'LinkedTxn' => [],
            'Line' =>
            [
              { 'Id' => '1',
                'LineNum' => 1,
                'Description' => 'Test Item',
                'Amount' => 1.5,
                'DetailType' => 'SalesItemLineDetail',
                'SalesItemLineDetail' =>
               { 'ItemRef' => { 'value' => '33', 'name' => 'Services' },
                 'TaxCodeRef' => { 'value' => 'NON' } } },
              { 'Amount' => 1.5,
                'DetailType' => 'SubTotalLineDetail',
                'SubTotalLineDetail' => {} }
            ],
            'CustomerRef' => { 'value' => '83', 'name' => 'Lola' },
            'DueDate' => '2019-09-01',
            'TotalAmt' => 1.5,
            'ApplyTaxAfterDiscount' => false,
            'PrintStatus' => 'NeedToPrint',
            'EmailStatus' => 'NotSet',
            'Balance' => 1.5 },
                'time' => '2020-01-15T06:25:44.543-08:00' }.to_json,
        headers: {}
      )
  end

  # Expense

  def stub_create_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: {
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
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
            }
          ]
        },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Purchase": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-09-20T09:44:50.133-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_create_expense_with_cutomer_entity
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: {
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
            "type": 'Customer'
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
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
            }
          ]
        },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Purchase": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-09-20T09:44:50.133-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_find_expense
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Purchase": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-09-20T09:44:50.133-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_update_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: {
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
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
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
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Purchase": {
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
            "SyncToken": '1',
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-09-20T09:44:50.133-07:00'
        }.to_json,
        headers: {}
      )
  end

  # Deposit

  def stub_create_deposit
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit')
      .with(
        body: {
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
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
            }
          ]
        },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Deposit": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-10-11T11:54:50.879-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_find_deposit
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Deposit": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-10-11T11:54:50.879-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_update_deposit
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit')
      .with(
        body: {
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
                "Entity": nil
              },
              "Amount": 123.45,
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
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
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Deposit": {
            "DepositToAccountRef": {
              "value": '123',
              "name": 'Cash on hand'
            },
            "TotalAmt": 246.9,
            "domain": 'QBO',
            "sparse": false,
            "Id": '123',
            "SyncToken": '1',
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
                "Id": '3',
                "LineNum": 1,
                "Description": 'Sample Transaction',
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
                "Id": '4',
                "LineNum": 2,
                "Description": 'Sample Transaction',
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
          },
          "time": '2019-10-11T11:54:50.879-07:00'
        }.to_json,
        headers: {}
      )
  end

  # Transfer

  def stub_create_transfer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer')
      .with(
        body: {
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
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Transfer": {
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
          "time": '2019-10-03T21:46:27.963-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_find_transfer
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Transfer": {
            "FromAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "ToAccountRef": {
              "value": '123',
              "name": 'Sample Account'
            },
            "Amount": 12_345.0,
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
          "time": '2019-10-03T21:46:27.963-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_update_transfer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer')
      .with(
        body: {
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
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Transfer": {
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
            "SyncToken": '1',
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
          "time": '2019-10-03T21:46:27.963-07:00'
        }.to_json,
        headers: {}
      )
  end

  # Bill

  def stub_create_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: {
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
              "Description": 'Sample Transaction'
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
              "Description": 'Sample Transaction'
            }
          ]
        },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Bill": {
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
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          "time": '2019-10-13T10:43:04.169-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_find_bill
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: {
          "Bill": {
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
              "value": 'USD',
              "name": 'United States Dollar'
            },
            "PrivateNote": 'Memo',
            "Line": [
              {
                "Id": '1',
                "LineNum": 1,
                "Description": 'Sample Transaction',
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
                "Description": 'Sample Transaction',
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
          "time": '2019-10-13T10:43:04.169-07:00'
        }.to_json,
        headers: {}
      )
  end

  def stub_update_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: {
          'Id' => '123',
          'CurrencyRef' => {
            'value' => 'USD',
            'name' => 'United States Dollar'
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
               'Description' => 'Sample Transaction'
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
               'Description' => 'Sample Transaction'
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
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'Bill' =>
          { 'DueDate' => '2019-09-01',
            'Balance' => 246.9,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '1',
            'MetaData' =>
            { 'CreateTime' => '2019-10-13T10:43:04-07:00',
              'LastUpdatedTime' => '2019-10-13T10:43:04-07:00' },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' },
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo',
            'Line' =>
            [
              { 'Id' => '3',
                'LineNum' => 1,
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'AccountBasedExpenseLineDetail',
                'AccountBasedExpenseLineDetail' =>
               { 'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                 'BillableStatus' => 'NotBillable',
                 'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                 'TaxCodeRef' => { 'value' => 'NON' } } },
              { 'Id' => '4',
                'LineNum' => 2,
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'AccountBasedExpenseLineDetail',
                'AccountBasedExpenseLineDetail' =>
                { 'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                  'BillableStatus' => 'NotBillable',
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'TaxCodeRef' => { 'value' => 'NON' } } }
            ],
            'VendorRef' => { 'value' => '123', 'name' => 'Sample Vendor' },
            'APAccountRef' => { 'value' => '123', 'name' => 'Accounts Payable (A/P)' },
            'TotalAmt' => 246.9 },
                'time' => '2019-10-13T10:43:04.169-07:00' }.to_json,
        headers: {}
      )
  end

  # JournalEntry

  def stub_create_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: { 'Id' => nil,
                'CurrencyRef' => { 'value' => 'USD' },
                'TxnDate' => '2019-09-01',
                'PrivateNote' => 'Memo',
                'DocNumber' => 'Ref123',
                'Line' =>
           [
             { 'DetailType' => 'JournalEntryLineDetail',
               'Amount' => 123.45,
               'JournalEntryLineDetail' =>
              { 'PostingType' => 'Credit',
                'AccountRef' => { 'value' => '123' },
                'ClassRef' => { 'value' => '123' },
                'DepartmentRef' => { 'value' => '123' } },
               'Description' => 'Sample Transaction' },
             { 'DetailType' => 'JournalEntryLineDetail',
               'Amount' => 123.45,
               'JournalEntryLineDetail' =>
               { 'PostingType' => 'Debit',
                 'AccountRef' => { 'value' => '123' },
                 'ClassRef' => { 'value' => '123' },
                 'DepartmentRef' => { 'value' => '123' } },
               'Description' => 'Sample Transaction' }
           ] },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'JournalEntry' =>
          { 'Adjustment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' =>
            { 'CreateTime' => '2019-10-13T13:28:14-07:00',
              'LastUpdatedTime' => '2019-10-13T13:28:14-07:00' },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo',
            'Line' =>
            [
              { 'Id' => '0',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
               { 'PostingType' => 'Credit',
                 'AccountRef' => { 'value' => '123', 'name' => 'Cash on hand' },
                 'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                 'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } },
              { 'Id' => '1',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
                { 'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } }
            ] },
                'time' => '2019-10-13T13:28:14.170-07:00' }.to_json,
        headers: {}
      )
  end

  def stub_find_journal_entry
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry/123')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'JournalEntry' =>
          { 'Adjustment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '0',
            'MetaData' =>
            { 'CreateTime' => '2019-10-13T13:28:14-07:00',
              'LastUpdatedTime' => '2019-10-13T13:28:14-07:00' },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo',
            'Line' =>
            [
              { 'Id' => '0',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
               { 'PostingType' => 'Credit',
                 'AccountRef' => { 'value' => '123', 'name' => 'Cash on hand' },
                 'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                 'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } },
              { 'Id' => '1',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
                { 'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } }
            ] },
                'time' => '2019-10-13T13:28:14.170-07:00' }.to_json,
        headers: {}
      )
  end

  def stub_update_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: { 'Adjustment' => false,
                'domain' => 'QBO',
                'sparse' => false,
                'Id' => '123',
                'SyncToken' => '0',
                'MetaData' =>
           { 'CreateTime' => '2019-10-13T13:28:14-07:00',
             'LastUpdatedTime' => '2019-10-13T13:28:14-07:00' },
                'DocNumber' => 'Ref123',
                'TxnDate' => '2019-09-01',
                'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
                'PrivateNote' => 'Memo',
                'Line' =>
           [
             { 'DetailType' => 'JournalEntryLineDetail',
               'JournalEntryLineDetail' =>
              { 'PostingType' => 'Credit',
                'AccountRef' => { 'value' => '123' },
                'ClassRef' => { 'value' => '123' },
                'DepartmentRef' => { 'value' => '123' } },
               'Amount' => 123.45,
               'Description' => 'Sample Transaction' },
             { 'DetailType' => 'JournalEntryLineDetail',
               'JournalEntryLineDetail' =>
               { 'PostingType' => 'Debit',
                 'AccountRef' => { 'value' => '123' },
                 'ClassRef' => { 'value' => '123' },
                 'DepartmentRef' => { 'value' => '123' } },
               'Amount' => 123.45,
               'Description' => 'Sample Transaction' }
           ] },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: { 'JournalEntry' =>
          { 'Adjustment' => false,
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '123',
            'SyncToken' => '1',
            'MetaData' =>
            { 'CreateTime' => '2019-10-13T13:28:14-07:00',
              'LastUpdatedTime' => '2019-10-13T13:28:14-07:00' },
            'DocNumber' => 'Ref123',
            'TxnDate' => '2019-09-01',
            'CurrencyRef' => { 'value' => 'USD', 'name' => 'United States Dollar' },
            'PrivateNote' => 'Memo',
            'Line' =>
            [
              { 'Id' => '2',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
               { 'PostingType' => 'Credit',
                 'AccountRef' => { 'value' => '123', 'name' => 'Cash on hand' },
                 'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                 'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } },
              { 'Id' => '3',
                'Description' => 'Sample Transaction',
                'Amount' => 123.45,
                'DetailType' => 'JournalEntryLineDetail',
                'JournalEntryLineDetail' =>
                { 'PostingType' => 'Debit',
                  'AccountRef' => { 'value' => '123', 'name' => 'Opening Balance Equity' },
                  'ClassRef' => { 'value' => '123', 'name' => 'Sample Class' },
                  'DepartmentRef' => { 'value' => '123', 'name' => 'Sample Department' } } }
            ] },
                'time' => '2019-10-13T13:28:14.170-07:00' }.to_json,
        headers: {}
      )
  end

  # Webhooks

  def webhook
    @webhook ||= LedgerSync::Ledgers::QuickBooksOnline::Webhook.new(
      payload: webhook_hash
    )
  end

  def webhook_hash
    @webhook_hash ||= {
      'eventNotifications' => [
        webhook_notification_hash(realm_id: 'realm_1'),
        webhook_notification_hash(realm_id: 'realm_2')
      ]

    }
  end

  def webhook_event
    @webhook_event ||= webhook.events.first
  end

  def webhook_event_hash(quickbooks_online_resource_type: 'Customer')
    {
      'name' => quickbooks_online_resource_type,
      'id' => '123',
      'operation' => 'Create',
      'lastUpdated' => '2015-10-05T14:42:19-0700'

    }
  end

  def webhook_notification
    @webhook_notification ||= webhook.notifications.first
  end

  def webhook_notification_hash(entities: nil, realm_id: 'realm_1')
    entities ||= [
      webhook_event_hash(quickbooks_online_resource_type: 'Customer'),
      webhook_event_hash(quickbooks_online_resource_type: 'Vendor')
    ]

    {
      'realmId' => realm_id,
      'dataChangeEvent' =>
       {
         'entities' => entities

       }

    }
  end
end
