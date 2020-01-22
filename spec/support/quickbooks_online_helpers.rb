# frozen_string_literal: true

module QuickBooksOnlineHelpers
  # Adaptor
  def quickbooks_online_adaptor
    LedgerSync.adaptors.quickbooks_online.new(
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

  def headers
    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => 'Bearer access_token',
      'Content-Type' => 'application/json',
      'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
    }
  end

  def stub_adaptor_refresh
    stub_request(:post, 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer')
      .with(
        body: { 'client_id' => 'client_id', 'client_secret' => 'client_secret', 'grant_type' => 'refresh_token', 'refresh_token' => 'refresh_token' },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: '{"token_type":"bearer","expires_in":3600,"refresh_token":"NEW_REFRESH_TOKEN","x_refresh_token_expires_in":1569480516,"access_token":"NEW_ACCESS_TOKEN"}',
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

  # Customer

  def stub_create_customer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer')
      .with(
        body: '{"Id":null,"DisplayName":"Sample Customer","PrimaryPhone":{"FreeFormNumber":null},"PrimaryEmailAddr":{"Address":"test@example.com"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  def stub_find_customer
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  def stub_search_customer
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Customer%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Customer%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"QueryResponse":{"Customer":[{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}]}}',
        headers: {}
      )
  end

  def stub_update_customer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer')
      .with(
        body: '{"Id":"123","DisplayName":"Sample Customer","PrimaryPhone":{"FreeFormNumber":null},"PrimaryEmailAddr":{"Address":"test@example.com"},"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"DefaultTaxCodeRef":{"value":"2"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  # Payment

  def stub_create_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: '{"Id":null,"TotalAmt":123.45,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"CustomerRef":{"value":"123"},"DepositToAccountRef":{"value":"123"},"ARAccountRef":{"value":"123"},"PaymentRefNum":"Ref123","PrivateNote":"Memo","ExchangeRate":1.0,"TxnDate":"2019-09-01","Line":[{"Amount":1.0,"LinkedTxn":[{"TxnId":"123","TxnType":"Invoice"}]}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Lola"},"DepositToAccountRef":{"value":"123"},"PaymentMethodRef":{"value":"29"},"PaymentRefNum":"123","TotalAmt":100.00,"UnappliedAmt":0,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-03T10:14:03-08:00","LastUpdatedTime":"2019-12-03T10:14:03-08:00"},"TxnDate":"2019-12-03","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[{"Amount":100.00,"LinkedTxn":[{"TxnId":"123","TxnType":"Invoice"}],"LineEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnId","Value":"123"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnOpenBalance","Value":"100.00"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnReferenceNumber","Value":"1038"},"nil":false,"globalScope":true,"typeSubstituted":false}]}}]},"time":"2019-12-23T06:51:43.325-08:00"}',
        headers: {}
      )
  end

  def stub_find_payment
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Lola"},"DepositToAccountRef":{"value":"123"},"PaymentMethodRef":{"value":"29"},"PaymentRefNum":"123","TotalAmt":100.00,"UnappliedAmt":0,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-03T10:14:03-08:00","LastUpdatedTime":"2019-12-03T10:14:03-08:00"},"TxnDate":"2019-12-03","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[{"Amount":100.00,"LinkedTxn":[{"TxnId":"123","TxnType":"Invoice"}],"LineEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnId","Value":"123"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnOpenBalance","Value":"100.00"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnReferenceNumber","Value":"1038"},"nil":false,"globalScope":true,"typeSubstituted":false}]}}]},"time":"2019-12-23T06:51:43.325-08:00"}',
        headers: {}
      )
  end

  def stub_update_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: '{"Id":"123","TotalAmt":123.45,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"CustomerRef":{"value":"123","name":"Lola"},"DepositToAccountRef":{"value":"123"},"ARAccountRef":{"value":"123"},"PaymentRefNum":"Ref123","PrivateNote":"Memo","ExchangeRate":1.0,"TxnDate":"2019-09-01","Line":[{"Amount":1.0,"LinkedTxn":[{"TxnId":"123","TxnType":"Invoice"}]}],"PaymentMethodRef":{"value":"29"},"UnappliedAmt":0,"ProcessPayment":false,"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-12-03T10:14:03-08:00","LastUpdatedTime":"2019-12-03T10:14:03-08:00"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Lola"},"DepositToAccountRef":{"value":"123"},"PaymentMethodRef":{"value":"29"},"PaymentRefNum":"123","TotalAmt":100.00,"UnappliedAmt":0,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-03T10:14:03-08:00","LastUpdatedTime":"2019-12-03T10:14:03-08:00"},"TxnDate":"2019-12-03","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[{"Amount":100.00,"LinkedTxn":[{"TxnId":"123","TxnType":"Invoice"}],"LineEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnId","Value":"123"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnOpenBalance","Value":"100.00"},"nil":false,"globalScope":true,"typeSubstituted":false},{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"txnReferenceNumber","Value":"1038"},"nil":false,"globalScope":true,"typeSubstituted":false}]}}]},"time":"2019-12-23T06:51:43.325-08:00"}',
        headers: {}
      )
  end

  # Invoice
  def stub_create_invoice
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"TxnDate":"2019-09-01","PrivateNote":"Memo 1","CustomerRef":{"value":"123"},"DepositToAccountRef":{"value":"123"},"Line":[{"Id":null,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"123"},"ClassRef":{"value":null}},"Amount":1.0,"Description":"Sample Description"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"173","SyncToken":"0","MetaData":{"CreateTime":"2020-01-15T06:25:44-08:00","LastUpdatedTime":"2020-01-15T06:25:44-08:00"},"CustomField":[{"DefinitionId":"1","Type":"StringType"}],"DocNumber":"1040","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo 1","LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"Test Item","Amount":1.50,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"33","name":"Services"},"TaxCodeRef":{"value":"NON"}}},{"Amount":1.50,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"CustomerRef":{"value":"83","name":"Lola"},"DueDate":"2019-09-01","TotalAmt":1.50,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":1.50},"time":"2020-01-15T06:25:44.543-08:00"}',
        headers: {}
      )
  end

  def stub_find_invoice
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"173","SyncToken":"0","MetaData":{"CreateTime":"2020-01-15T06:25:44-08:00","LastUpdatedTime":"2020-01-15T06:25:44-08:00"},"CustomField":[{"DefinitionId":"1","Type":"StringType"}],"DocNumber":"1040","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo 1","LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"Test Item","Amount":1.50,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"33","name":"Services"},"TaxCodeRef":{"value":"NON"}}},{"Amount":1.50,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"CustomerRef":{"value":"83","name":"Lola"},"DueDate":"2019-09-01","TotalAmt":1.50,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":1.50},"time":"2020-01-15T06:25:44.543-08:00"}',
        headers: {}
      )
  end

  def stub_update_invoice
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/invoice')
      .with(
        body: '{"Id":"123","CurrencyRef":{"value":"USD","name":"United States Dollar"},"TxnDate":"2019-09-01","PrivateNote":"Memo 1","CustomerRef":{"value":"123","name":"Lola"},"DepositToAccountRef":{"value":"123"},"Line":[{"Id":null,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"123"},"ClassRef":{"value":null}},"Amount":1.0,"Description":"Sample Description"}],"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2020-01-15T06:25:44-08:00","LastUpdatedTime":"2020-01-15T06:25:44-08:00"},"CustomField":[{"DefinitionId":"1","Type":"StringType"}],"DocNumber":"1040","LinkedTxn":[],"DueDate":"2019-09-01","TotalAmt":1.5,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":1.5}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"173","SyncToken":"0","MetaData":{"CreateTime":"2020-01-15T06:25:44-08:00","LastUpdatedTime":"2020-01-15T06:25:44-08:00"},"CustomField":[{"DefinitionId":"1","Type":"StringType"}],"DocNumber":"1040","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo 1","LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"Test Item","Amount":1.50,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"33","name":"Services"},"TaxCodeRef":{"value":"NON"}}},{"Amount":1.50,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"CustomerRef":{"value":"83","name":"Lola"},"DueDate":"2019-09-01","TotalAmt":1.50,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":1.50},"time":"2020-01-15T06:25:44.543-08:00"}',
        headers: {}
      )
  end

  # Vendor

  def stub_create_vendor
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor')
      .with(
        body: '{"Id":null,"DisplayName":"Sample Vendor","GivenName":"Sample","FamilyName":"Vendor","PrimaryEmailAddr":{"Address":"test@example.com"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:03:28-07:00","LastUpdatedTime":"2019-09-12T09:03:28-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:03:28.905-07:00"}',
        headers: {}
      )
  end

  def stub_find_vendor
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:05:52-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:06:41.852-07:00"}',
        headers: {}
      )
  end

  def stub_search_vendor
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Vendor%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Vendor%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"QueryResponse":{"Vendor":[{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:05:52-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}}]}}',
        headers: {}
      )
  end

  def stub_update_vendor
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor')
      .with(
        body: '{"Id":"123","DisplayName":"Sample Vendor","GivenName":"Sample","FamilyName":"Vendor","PrimaryEmailAddr":{"Address":"test@example.com"},"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:05:52-07:00"},"PrintOnCheckName":"Sample Vendor","Active":true}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:06:44-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:06:44.249-07:00"}',
        headers: {}
      )
  end

  # Account

  def stub_create_account
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: {
          'Id' => nil,
          'Name' => 'Sample Account',
          'AccountType' => 'Bank',
          'AccountSubType' => 'CashOnHand',
          'AcctNum' => '1001',
          'CurrencyRef' => {
            'value' => 'ZZZ',
            'name' => 'Test Currency 1'
          },
          'Classification' => 'Asset',
          'Description' => 'This is Sample Account',
          'Active' => true
        }.to_json,
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:22:16.650-07:00"}',
        headers: {}
      )
  end

  # Ref: https://github.com/LedgerSync/ledger_sync/issues/86
  def stub_create_account_with_missing_classification
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: '{"Id":null,"Name":"Sample Account","AccountType":"Bank","AccountSubType":"CashOnHand","AcctNum":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"Classification":null,"Description":"This is Sample Account","Active":true}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":null,"AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:22:16.650-07:00"}',
        headers: {}
      )
  end

  def stub_find_account
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:34:00.276-07:00"}',
        headers: {}
      )
  end

  def stub_search_account
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Account%20WHERE%20Name%20LIKE%20'%25Sample%20Account%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"QueryResponse":{"Account":[{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}}]}}',
        headers: {}
      )
  end

  def stub_update_account
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: JSON.parse('{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"},"AcctNum":"1001","Description":"This is Sample Account"}'),
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Account":{"Name":"Sample","SubAccount":false,"FullyQualifiedName":"Sample","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:36:42.241-07:00"}',
        headers: {}
      )
  end

  # Expense

  def stub_create_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"PaymentType":"Cash","TxnDate":"2019-09-01","PrivateNote":"Memo","ExchangeRate":1.0,"EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"DocNumber":"Ref123","AccountRef":{"value":"123"},"Line":[{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  def stub_create_expense_with_cutomer_entity
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"PaymentType":"Cash","TxnDate":"2019-09-01","PrivateNote":"Memo","ExchangeRate":1.0,"EntityRef":{"value":"123","type":"Customer"},"DocNumber":"Ref123","AccountRef":{"value":"123"},"Line":[{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  def stub_find_expense
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  def stub_update_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: '{"Id":"123","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PaymentType":"Cash","TxnDate":"2019-09-01","PrivateNote":"Memo","ExchangeRate":1.0,"EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"DocNumber":"Ref123","AccountRef":{"value":"123","name":"Sample Account"},"Line":[{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"}],"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[]}', headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  # Deposit

  def stub_create_deposit
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"TxnDate":"2019-09-01","PrivateNote":"Memo","ExchangeRate":1.0,"DepositToAccountRef":{"value":"123"},"DepartmentRef":{"value":"123"},"Line":[{"Id":null,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123"},"Entity":{"value":"245","name":"Sample Vendor","type":"Vendor"}},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123"},"Entity":null},"Amount":123.45,"Description":"Sample Transaction"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Deposit":{"DepositToAccountRef":{"value":"123","name":"Cash on hand"},"TotalAmt":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-11T11:54:50-07:00","LastUpdatedTime":"2019-10-11T11:54:50-07:00"},"TxnDate":"2019-09-01","DepartmentRef":{"value":"123","name":"Sample Department"},"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","LineNum":1,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"2","LineNum":2,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}}]},"time":"2019-10-11T11:54:50.879-07:00"}',
        headers: {}
      )
  end

  def stub_find_deposit
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Deposit":{"DepositToAccountRef":{"value":"123","name":"Cash on hand"},"TotalAmt":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-11T11:54:50-07:00","LastUpdatedTime":"2019-10-11T11:54:50-07:00"},"TxnDate":"2019-09-01","DepartmentRef":{"value":"123","name":"Sample Department"},"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","LineNum":1,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"2","LineNum":2,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}}]},"time":"2019-10-11T11:54:50.879-07:00"}',
        headers: {}
      )
  end

  def stub_update_deposit
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit')
      .with(
        body: '{"Id":"123","CurrencyRef":{"value":"USD","name":"United States Dollar"},"TxnDate":"2019-09-01","PrivateNote":"Memo","ExchangeRate":1.0,"DepositToAccountRef":{"value":"123","name":"Cash on hand"},"DepartmentRef":{"value":"123","name":"Sample Department"},"Line":[{"Id":null,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123"},"Entity":null},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123"},"Entity":null},"Amount":123.45,"Description":"Sample Transaction"}],"TotalAmt":246.9,"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-10-11T11:54:50-07:00","LastUpdatedTime":"2019-10-11T11:54:50-07:00"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Deposit":{"DepositToAccountRef":{"value":"123","name":"Cash on hand"},"TotalAmt":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-10-11T11:54:50-07:00","LastUpdatedTime":"2019-10-11T11:54:50-07:00"},"TxnDate":"2019-09-01","DepartmentRef":{"value":"123","name":"Sample Department"},"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"3","LineNum":1,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"4","LineNum":2,"Description":"Sample Transaction","Amount":123.45,"DetailType":"DepositLineDetail","DepositLineDetail":{"AccountRef":{"value":"123","name":"Cash on hand"}}}]},"time":"2019-10-11T11:54:50.879-07:00"}',
        headers: {}
      )
  end

  # Transfer

  def stub_create_transfer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer')
      .with(
        body: '{"Id":null,"Amount":123.45,"PrivateNote":"Memo","FromAccountRef":{"value":"123"},"ToAccountRef":{"value":"123"},"TxnDate":"2019-09-01","CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Transfer":{"FromAccountRef":{"value":"123","name":"Sample Account"},"ToAccountRef":{"value":"123","name":"Sample Account"},"Amount":123.45,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-03T21:46:28-07:00","LastUpdatedTime":"2019-10-03T21:46:28-07:00"},"TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo"},"time":"2019-10-03T21:46:27.963-07:00"}',
        headers: {}
      )
  end

  def stub_find_transfer
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Transfer":{"FromAccountRef":{"value":"123","name":"Sample Account"},"ToAccountRef":{"value":"123","name":"Sample Account"},"Amount":12345.0,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-03T21:46:28-07:00","LastUpdatedTime":"2019-10-03T21:46:28-07:00"},"TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo"},"time":"2019-10-03T21:46:27.963-07:00"}',
        headers: {}
      )
  end

  def stub_update_transfer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer')
      .with(
        body: '{"Id":"123","Amount":123.45,"PrivateNote":"Memo","FromAccountRef":{"value":"123","name":"Sample Account"},"ToAccountRef":{"value":"123","name":"Sample Account"},"TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-10-03T21:46:28-07:00","LastUpdatedTime":"2019-10-03T21:46:28-07:00"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Transfer":{"FromAccountRef":{"value":"123","name":"Sample Account"},"ToAccountRef":{"value":"123","name":"Sample Account"},"Amount":123.45,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-10-03T21:46:28-07:00","LastUpdatedTime":"2019-10-03T21:46:28-07:00"},"TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo"},"time":"2019-10-03T21:46:27.963-07:00"}',
        headers: {}
      )
  end

  # Bill

  def stub_create_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 3"},"DueDate":"2019-09-01","PrivateNote":"Memo 1","TxnDate":null,"VendorRef":{"value":"123"},"APAccountRef":{"value":"123"},"DocNumber":"Ref1","Line":[{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"124"}},"Amount":123.45,"Description":"Test Line Item 1"},{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"124"}},"Amount":123.45,"Description":"Test Line Item 2"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Bill":{"DueDate":"2019-09-01","Balance":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T10:43:04-07:00","LastUpdatedTime":"2019-10-13T10:43:04-07:00"},"DocNumber":"Ref1","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","LineNum":1,"Description":"Test Line Item 2","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"124","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","LineNum":2,"Description":"Test Line Item 1","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}],"VendorRef":{"value":"123","name":"Sample Vendor"},"APAccountRef":{"value":"123","name":"Accounts Payable (A/P)"},"TotalAmt":246.9},"time":"2019-10-13T10:43:04.169-07:00"}',
        headers: {}
      )
  end

  def stub_find_bill
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Bill":{"DueDate":"2019-09-01","Balance":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T10:43:04-07:00","LastUpdatedTime":"2019-10-13T10:43:04-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","LineNum":1,"Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","LineNum":2,"Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}],"VendorRef":{"value":"123","name":"Sample Vendor"},"APAccountRef":{"value":"123","name":"Accounts Payable (A/P)"},"TotalAmt":246.9},"time":"2019-10-13T10:43:04.169-07:00"}',
        headers: {}
      )
  end

  def stub_update_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: '{"Id":"123","CurrencyRef":{"value":"USD","name":"United States Dollar"},"DueDate":"2019-09-01","PrivateNote":"Memo","TxnDate":"2019-09-01","VendorRef":{"value":"123","name":"Sample Vendor"},"APAccountRef":{"value":"123","name":"Accounts Payable (A/P)"},"DocNumber":"Ref123","Line":[{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"},{"Id":null,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"}],"Balance":246.9,"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T10:43:04-07:00","LastUpdatedTime":"2019-10-13T10:43:04-07:00"},"TotalAmt":246.9}', headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Bill":{"DueDate":"2019-09-01","Balance":246.9,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-10-13T10:43:04-07:00","LastUpdatedTime":"2019-10-13T10:43:04-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"3","LineNum":1,"Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"4","LineNum":2,"Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Opening Balance Equity"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}],"VendorRef":{"value":"123","name":"Sample Vendor"},"APAccountRef":{"value":"123","name":"Accounts Payable (A/P)"},"TotalAmt":246.9},"time":"2019-10-13T10:43:04.169-07:00"}',
        headers: {}
      )
  end

  # JournalEntry

  def stub_create_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: '{"Id":null,"CurrencyRef":{"value":"ZZZ","name":"Test Currency 1"},"TxnDate":"2019-09-01","PrivateNote":"Memo","DocNumber":"Ref123","Line":[{"DetailType":"JournalEntryLineDetail","Amount":123.45,"JournalEntryLineDetail":{"PostingType":"Credit","AccountRef":{"value":"123"}},"Description":"Sample Transaction"},{"DetailType":"JournalEntryLineDetail","Amount":123.45,"JournalEntryLineDetail":{"PostingType":"Debit","AccountRef":{"value":"123"}},"Description":"Sample Transaction"}]}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"JournalEntry":{"Adjustment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T13:28:14-07:00","LastUpdatedTime":"2019-10-13T13:28:14-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"0","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Credit","AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Debit","AccountRef":{"value":"123","name":"Opening Balance Equity"}}}]},"time":"2019-10-13T13:28:14.170-07:00"}',
        headers: {}
      )
  end

  def stub_find_journal_entry
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"JournalEntry":{"Adjustment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T13:28:14-07:00","LastUpdatedTime":"2019-10-13T13:28:14-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"0","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Credit","AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Debit","AccountRef":{"value":"123","name":"Opening Balance Equity"}}}]},"time":"2019-10-13T13:28:14.170-07:00"}',
        headers: {}
      )
  end

  def stub_update_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: JSON.parse('{"Adjustment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-10-13T13:28:14-07:00","LastUpdatedTime":"2019-10-13T13:28:14-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Credit","AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"},{"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Debit","AccountRef":{"value":"123"}},"Amount":123.45,"Description":"Sample Transaction"}]}'),
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"JournalEntry":{"Adjustment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-10-13T13:28:14-07:00","LastUpdatedTime":"2019-10-13T13:28:14-07:00"},"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Credit","AccountRef":{"value":"123","name":"Cash on hand"}}},{"Id":"3","Description":"Sample Transaction","Amount":123.45,"DetailType":"JournalEntryLineDetail","JournalEntryLineDetail":{"PostingType":"Debit","AccountRef":{"value":"123","name":"Opening Balance Equity"}}}]},"time":"2019-10-13T13:28:14.170-07:00"}',
        headers: {}
      )
  end

  # Department

  def stub_create_department
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/department')
      .with(
        body: '{"Id":null,"Name":"Test Department","Active":true,"SubDepartment":false,"FullyQualifiedName":null}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Department":{"Name":"Test Department","SubDepartment":true,"ParentRef":{"value":null},"FullyQualifiedName":"Test Department","Active":true,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T14:24:59-08:00","LastUpdatedTime":"2019-12-04T14:24:59-08:00"}},"time":"2019-12-04T14:24:59.846-08:00"}',
        headers: {}
      )
  end

  def stub_find_department
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/department/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Department":{"Name":"Test Department","SubDepartment":true,"ParentRef":{"value":null},"FullyQualifiedName":"Test Department","Active":true,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T14:24:59-08:00","LastUpdatedTime":"2019-12-04T14:24:59-08:00"}},"time":"2019-12-04T14:24:59.846-08:00"}',
        headers: {}
      )
  end

  def stub_search_department
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Department%20WHERE%20Name%20LIKE%20'%25Test%20Department%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"QueryResponse":{"Department":[{"Name":"Test Department","SubDepartment":true,"ParentRef":{"value":null},"FullyQualifiedName":"Test Department","Active":true,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T14:24:59-08:00","LastUpdatedTime":"2019-12-04T14:24:59-08:00"}}]}}',
        headers: {}
      )
  end

  def stub_update_department
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/department')
      .with(
        body: '{"Id":"123","Name":"Test Department","Active":true,"SubDepartment":false,"FullyQualifiedName":null,"ParentRef":{"value":null},"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T14:24:59-08:00","LastUpdatedTime":"2019-12-04T14:24:59-08:00"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Department":{"Name":"Test Department","SubDepartment":true,"ParentRef":{"value":null},"FullyQualifiedName":"Renamed Department:Test Department","Active":true,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T14:24:59-08:00","LastUpdatedTime":"2019-12-04T14:24:59-08:00"}},"time":"2019-12-04T14:24:59.846-08:00"}',
        headers: {}
      )
  end

  # Class

  def stub_create_ledger_class
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/class')
      .with(
        body: '{"Id":null,"Name":"Test Class","Active":true,"SubClass":false,"FullyQualifiedName":null,"ParentRef":{"value":null}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Class":{"Name":"Test Class","SubClass":false,"FullyQualifiedName":"Test Class","Active":true,"domain":"QBO","sparse":false,"Id":"5000000000000137302","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T08:34:10-08:00","LastUpdatedTime":"2019-12-04T08:34:10-08:00"}},"time":"2019-12-04T08:34:10.943-08:00"}',
        headers: {}
      )
  end

  def stub_find_ledger_class
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/class/123')
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Class":{"Name":"Test Class","SubClass":false,"FullyQualifiedName":"Test Class","Active":true,"domain":"QBO","sparse":false,"Id":"5000000000000137302","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T08:34:10-08:00","LastUpdatedTime":"2019-12-04T08:34:10-08:00"}},"time":"2019-12-04T08:34:10.943-08:00"}',
        headers: {}
      )
  end

  def stub_search_ledger_class
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Class%20WHERE%20Name%20LIKE%20'%25Test%20Class%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
      .with(
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"QueryResponse":{"Class":[{"Name":"Test Class","SubClass":false,"FullyQualifiedName":"Test Class","Active":true,"domain":"QBO","sparse":false,"Id":"5000000000000137302","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T08:34:10-08:00","LastUpdatedTime":"2019-12-04T08:34:10-08:00"}}]}}',
        headers: {}
      )
  end

  def stub_update_ledger_class
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/class')
      .with(
        body: '{"Id":"123","Name":"Test Class","Active":true,"SubClass":false,"FullyQualifiedName":null,"ParentRef":{"value":null},"domain":"QBO","sparse":false,"SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T08:34:10-08:00","LastUpdatedTime":"2019-12-04T08:34:10-08:00"}}',
        headers: headers
      )
      .to_return(
        status: 200,
        body: '{"Class":{"Name":"Test Class","SubClass":false,"FullyQualifiedName":"Test Class","Active":true,"domain":"QBO","sparse":false,"Id":"5000000000000137302","SyncToken":"0","MetaData":{"CreateTime":"2019-12-04T08:34:10-08:00","LastUpdatedTime":"2019-12-04T08:34:10-08:00"}},"time":"2019-12-04T08:35:42.814-08:00"}',
        headers: {}
      )
  end

  # Webhooks

  def webhook
    @webhook ||= LedgerSync::Adaptors::QuickBooksOnline::Webhook.new(
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
