# frozen_string_literal: true

module QuickBooksHelpers
  # Adaptor

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

  # Customer

  def stub_create_customer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer')
      .with(
        body: "{\"Id\":\"123\",\"DisplayName\":\"Sample Customer\",\"PrimaryPhone\":{\"FreeFormNumber\":null},\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
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
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  def stub_find_customer
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer/123')
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
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  def stub_search_customer
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Customer%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Customer%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
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
        body: '{"QueryResponse":{"Customer":[{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}]}}',
        headers: {}
      )
  end

  def stub_update_customer
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer')
      .with(
        body: "{\"Id\":\"123\",\"DisplayName\":\"Sample Customer\",\"PrimaryPhone\":{\"FreeFormNumber\":null},\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"DefaultTaxCodeRef\":{\"value\":\"2\"}}",
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
        body: '{"Customer":{"Taxable":true,"Job":false,"BillWithParent":false,"Balance":0,"BalanceWithJobs":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"PreferredDeliveryMethod":"Print","domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-07-11T13:04:17-07:00","LastUpdatedTime":"2019-07-11T13:04:17-07:00"},"FullyQualifiedName":"Sample Customer","DisplayName":"Sample Customer","PrintOnCheckName":"Sample Customer","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"},"DefaultTaxCodeRef":{"value":"2"}}}',
        headers: {}
      )
  end

  # Payment

  def stub_create_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: "{\"Id\":null,\"TotalAmt\":123.45,\"CurrencyRef\":{\"value\":\"USD\"},\"CustomerRef\":{\"value\":\"123\"}}",
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
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Sample Customer"},"DepositToAccountRef":{"value":"4"},"TotalAmt":123.45,"UnappliedAmt":123.45,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:54:17-07:00","LastUpdatedTime":"2019-07-11T13:54:17-07:00"},"TxnDate":"2019-07-11","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[]}}',
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
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Sample Customer"},"DepositToAccountRef":{"value":"4"},"TotalAmt":123.45,"UnappliedAmt":123.45,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-07-11T13:54:17-07:00","LastUpdatedTime":"2019-07-11T13:54:17-07:00"},"TxnDate":"2019-07-11","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[]}}',
        headers: {}
      )
  end

  def stub_update_payment
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment')
      .with(
        body: "{\"Id\":\"123\",\"TotalAmt\":123.45,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"CustomerRef\":{\"value\":\"123\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"UnappliedAmt\":123.45,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"Line\":[]}",
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
        body: '{"Payment":{"CustomerRef":{"value":"123","name":"Sample Customer"},"DepositToAccountRef":{"value":"4"},"TotalAmt":123.45,"UnappliedAmt":123.45,"ProcessPayment":false,"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-07-11T13:54:17-07:00","LastUpdatedTime":"2019-07-11T13:54:17-07:00"},"TxnDate":"2019-07-11","CurrencyRef":{"value":"USD","name":"United States Dollar"},"Line":[]}}',
        headers: {}
      )
  end

  # Vendor

  def stub_create_vendor
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor')
      .with(
        body: "{\"Id\":null,\"DisplayName\":\"Sample Vendor\",\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
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
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:03:28-07:00","LastUpdatedTime":"2019-09-12T09:03:28-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:03:28.905-07:00"}',
        headers: {}
      )
  end

  def stub_find_vendor
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor/123')
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
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:05:52-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:06:41.852-07:00"}',
        headers: {}
      )
  end

  def stub_search_vendor
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Vendor%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Vendor%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
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
        body: '{"QueryResponse":{"Vendor":[{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:05:52-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}}]}}',
        headers: {}
      )
  end

  def stub_update_vendor
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor')
      .with(
        body: "{\"Id\":\"123\",\"DisplayName\":\"Sample Vendor\",\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:05:52-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:05:52-07:00\"},\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true}",
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
        body: '{"Vendor":{"Balance":0,"Vendor1099":false,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-12T09:05:52-07:00","LastUpdatedTime":"2019-09-12T09:06:44-07:00"},"GivenName":"Sample","FamilyName":"Vendor","DisplayName":"Sample Vendor","PrintOnCheckName":"Sample Vendor","Active":true,"PrimaryEmailAddr":{"Address":"test@example.com"}},"time":"2019-09-12T09:06:44.249-07:00"}',
        headers: {}
      )
  end

  # Account

  def stub_create_account
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: "{\"Id\":null,\"Name\":\"Sample Account\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"AcctNum\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"Classification\":\"Asset\",\"Description\":\"This is Sample Account\",\"Active\":true}",
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
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:22:16.650-07:00"}',
        headers: {}
      )
  end

  # Ref: https://github.com/LedgerSync/ledger_sync/issues/86
  def stub_create_account_with_missing_classification
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: "{\"Id\":null,\"Name\":\"Sample Account\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"AcctNum\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"Classification\":null,\"Description\":\"This is Sample Account\",\"Active\":true}",
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
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":null,"AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:22:16.650-07:00"}',
        headers: {}
      )
  end

  def stub_find_account
    stub_request(:get, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account/123')
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
        body: '{"Account":{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:34:00.276-07:00"}',
        headers: {}
      )
  end

  def stub_search_account
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Account%20WHERE%20Name%20LIKE%20'%25Sample%20Account%25'%20STARTPOSITION%201%20MAXRESULTS%2010")
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
        body: '{"QueryResponse":{"Account":[{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}}]}}',
        headers: {}
      )
  end

  def stub_update_account
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account')
      .with(
        body: '{"Name":"Sample Account","SubAccount":false,"FullyQualifiedName":"Sample Account","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"},"AcctNum":null,"Description":"This is Sample Account"}',
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
        body: '{"Account":{"Name":"Sample","SubAccount":false,"FullyQualifiedName":"Sample","Active":true,"Classification":"Asset","AccountType":"Bank","AccountSubType":"CashOnHand","CurrentBalance":0,"CurrentBalanceWithSubAccounts":0,"CurrencyRef":{"value":"USD","name":"United States Dollar"},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-12T12:22:16-07:00","LastUpdatedTime":"2019-09-12T12:22:16-07:00"}},"time":"2019-09-12T12:36:42.241-07:00"}',
        headers: {}
      )
  end

  # Expense

  def stub_create_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: "{\"Id\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"PaymentType\":\"Cash\",\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"ExchangeRate\":1.0,\"EntityRef\":{\"value\":\"123\"},\"DocNumber\":\"Ref123\",\"AccountRef\":{\"value\":\"123\"},\"Line\":[{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}]}",
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
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
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
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"0","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  def stub_update_expense
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase')
      .with(
        body: "{\"Id\":\"123\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PaymentType\":\"Cash\",\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"ExchangeRate\":1.0,\"EntityRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\",\"type\":\"Vendor\"},\"DocNumber\":\"Ref123\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"Line\":[{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}],\"TotalAmt\":24690.0,\"PurchaseEx\":{\"any\":[{\"name\":\"{http://schema.intuit.com/finance/v3}NameValue\",\"declaredType\":\"com.intuit.schema.finance.v3.NameValue\",\"scope\":\"javax.xml.bind.JAXBElement$GlobalScope\",\"value\":{\"Name\":\"TxnType\",\"Value\":\"54\"},\"nil\":false,\"globalScope\":true,\"typeSubstituted\":false}]},\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-20T09:44:50-07:00\",\"LastUpdatedTime\":\"2019-09-20T09:44:50-07:00\"},\"CustomField\":[]}",        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: '{"Purchase":{"AccountRef":{"value":"123","name":"Sample Account"},"PaymentType":"Cash","EntityRef":{"value":"123","name":"Sample Vendor","type":"Vendor"},"TotalAmt":24690.0,"PurchaseEx":{"any":[{"name":"{http://schema.intuit.com/finance/v3}NameValue","declaredType":"com.intuit.schema.finance.v3.NameValue","scope":"javax.xml.bind.JAXBElement$GlobalScope","value":{"Name":"TxnType","Value":"54"},"nil":false,"globalScope":true,"typeSubstituted":false}]},"domain":"QBO","sparse":false,"Id":"123","SyncToken":"1","MetaData":{"CreateTime":"2019-09-20T09:44:50-07:00","LastUpdatedTime":"2019-09-20T09:44:50-07:00"},"CustomField":[],"DocNumber":"Ref123","TxnDate":"2019-09-01","CurrencyRef":{"value":"USD","name":"United States Dollar"},"PrivateNote":"Memo","Line":[{"Id":"1","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}},{"Id":"2","Description":"Sample Transaction","Amount":123.45,"DetailType":"AccountBasedExpenseLineDetail","AccountBasedExpenseLineDetail":{"AccountRef":{"value":"123","name":"Sample Account"},"BillableStatus":"NotBillable","TaxCodeRef":{"value":"NON"}}}]},"time":"2019-09-20T09:44:50.133-07:00"}',
        headers: {}
      )
  end

  # Deposit

  def stub_create_deposit
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit").
      with(
        body: "{\"Id\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"ExchangeRate\":1.0,\"DepositToAccountRef\":{\"value\":\"123\"},\"Line\":[{\"Id\":null,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}]}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Deposit\":{\"DepositToAccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"},\"TotalAmt\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-11T11:54:50-07:00\",\"LastUpdatedTime\":\"2019-10-11T11:54:50-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"2\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}}]},\"time\":\"2019-10-11T11:54:50.879-07:00\"}",
        headers: {}
      )
  end

  def stub_find_deposit
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Deposit\":{\"DepositToAccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"},\"TotalAmt\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-11T11:54:50-07:00\",\"LastUpdatedTime\":\"2019-10-11T11:54:50-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"2\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}}]},\"time\":\"2019-10-11T11:54:50.879-07:00\"}",
        headers: {}
      )
  end

  def stub_update_deposit
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/deposit").
      with(
        body: "{\"Id\":\"123\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"ExchangeRate\":1.0,\"DepositToAccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"},\"Line\":[{\"Id\":null,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}],\"TotalAmt\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-11T11:54:50-07:00\",\"LastUpdatedTime\":\"2019-10-11T11:54:50-07:00\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Deposit\":{\"DepositToAccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"},\"TotalAmt\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-10-11T11:54:50-07:00\",\"LastUpdatedTime\":\"2019-10-11T11:54:50-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"3\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"4\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"DepositLineDetail\",\"DepositLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}}]},\"time\":\"2019-10-11T11:54:50.879-07:00\"}",
        headers: {}
      )
  end

  # Transfer

  def stub_create_transfer
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer").
      with(
        body: "{\"Id\":null,\"Amount\":123.45,\"PrivateNote\":\"Memo\",\"FromAccountRef\":{\"value\":\"123\"},\"ToAccountRef\":{\"value\":\"123\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Transfer\":{\"FromAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"ToAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"Amount\":123.45,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-03T21:46:28-07:00\",\"LastUpdatedTime\":\"2019-10-03T21:46:28-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\"},\"time\":\"2019-10-03T21:46:27.963-07:00\"}",
        headers: {}
      )
  end

  def stub_find_transfer
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Transfer\":{\"FromAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"ToAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"Amount\":12345.0,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-03T21:46:28-07:00\",\"LastUpdatedTime\":\"2019-10-03T21:46:28-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\"},\"time\":\"2019-10-03T21:46:27.963-07:00\"}",
        headers: {}
      )
  end

  def stub_update_transfer
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/transfer").
      with(
        body: "{\"Id\":\"123\",\"Amount\":123.45,\"PrivateNote\":\"Memo\",\"FromAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"ToAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-03T21:46:28-07:00\",\"LastUpdatedTime\":\"2019-10-03T21:46:28-07:00\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>/Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }).
      to_return(
        status: 200,
        body: "{\"Transfer\":{\"FromAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"ToAccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"Amount\":123.45,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-10-03T21:46:28-07:00\",\"LastUpdatedTime\":\"2019-10-03T21:46:28-07:00\"},\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\"},\"time\":\"2019-10-03T21:46:27.963-07:00\"}",
        headers: {}
      )
  end

  # Bill

  def stub_create_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: "{\"Id\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"DueDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"TxnDate\":\"2019-09-01\",\"VendorRef\":{\"value\":\"123\"},\"APAccountRef\":{\"value\":\"123\"},\"DocNumber\":\"Ref123\",\"Line\":[{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}]}",
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
        body: "{\"Bill\":{\"DueDate\":\"2019-09-01\",\"Balance\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T10:43:04-07:00\",\"LastUpdatedTime\":\"2019-10-13T10:43:04-07:00\"},\"DocNumber\":\"Ref123\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}],\"VendorRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\"},\"APAccountRef\":{\"value\":\"123\",\"name\":\"Accounts Payable (A/P)\"},\"TotalAmt\":246.9},\"time\":\"2019-10-13T10:43:04.169-07:00\"}",
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
        body: "{\"Bill\":{\"DueDate\":\"2019-09-01\",\"Balance\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T10:43:04-07:00\",\"LastUpdatedTime\":\"2019-10-13T10:43:04-07:00\"},\"DocNumber\":\"Ref123\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}],\"VendorRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\"},\"APAccountRef\":{\"value\":\"123\",\"name\":\"Accounts Payable (A/P)\"},\"TotalAmt\":246.9},\"time\":\"2019-10-13T10:43:04.169-07:00\"}",
        headers: {}
      )
  end

  def stub_update_bill
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/bill')
      .with(
        body: "{\"Id\":\"123\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"DueDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"TxnDate\":\"2019-09-01\",\"VendorRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\"},\"APAccountRef\":{\"value\":\"123\",\"name\":\"Accounts Payable (A/P)\"},\"DocNumber\":\"Ref123\",\"Line\":[{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"Id\":null,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}],\"Balance\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T10:43:04-07:00\",\"LastUpdatedTime\":\"2019-10-13T10:43:04-07:00\"},\"TotalAmt\":246.9}",        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer access_token',
          'Content-Type' => 'application/json',
          'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
        }
      )
      .to_return(
        status: 200,
        body: "{\"Bill\":{\"DueDate\":\"2019-09-01\",\"Balance\":246.9,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-10-13T10:43:04-07:00\",\"LastUpdatedTime\":\"2019-10-13T10:43:04-07:00\"},\"DocNumber\":\"Ref123\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"3\",\"LineNum\":1,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"4\",\"LineNum\":2,\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}],\"VendorRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\"},\"APAccountRef\":{\"value\":\"123\",\"name\":\"Accounts Payable (A/P)\"},\"TotalAmt\":246.9},\"time\":\"2019-10-13T10:43:04.169-07:00\"}",
        headers: {}
      )
  end

  # JournalEntry

  def stub_create_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: "{\"Id\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"Line\":[{\"DetailType\":\"JournalEntryLineDetail\",\"Amount\":123.45,\"JournalEntryLineDetail\":{\"PostingType\":\"Credit\",\"AccountRef\":{\"value\":\"123\"}},\"Description\":\"Sample Transaction\"},{\"DetailType\":\"JournalEntryLineDetail\",\"Amount\":123.45,\"JournalEntryLineDetail\":{\"PostingType\":\"Debit\",\"AccountRef\":{\"value\":\"123\"}},\"Description\":\"Sample Transaction\"}]}",
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
        body: "{\"JournalEntry\":{\"Adjustment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T13:28:14-07:00\",\"LastUpdatedTime\":\"2019-10-13T13:28:14-07:00\"},\"DocNumber\":\"2\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"0\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Credit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Debit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"}}}]},\"time\":\"2019-10-13T13:28:14.170-07:00\"}",
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
        body: "{\"JournalEntry\":{\"Adjustment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T13:28:14-07:00\",\"LastUpdatedTime\":\"2019-10-13T13:28:14-07:00\"},\"DocNumber\":\"2\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"0\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Credit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Debit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"}}}]},\"time\":\"2019-10-13T13:28:14.170-07:00\"}",
        headers: {}
      )
  end

  def stub_update_journal_entry
    stub_request(:post, 'https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/journalentry')
      .with(
        body: JSON.parse("{\"Adjustment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-10-13T13:28:14-07:00\",\"LastUpdatedTime\":\"2019-10-13T13:28:14-07:00\"},\"DocNumber\":\"2\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Credit\",\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"},{\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Debit\",\"AccountRef\":{\"value\":\"123\"}},\"Amount\":123.45,\"Description\":\"Sample Transaction\"}]}"),
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
        body: "{\"JournalEntry\":{\"Adjustment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-10-13T13:28:14-07:00\",\"LastUpdatedTime\":\"2019-10-13T13:28:14-07:00\"},\"DocNumber\":\"2\",\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"2\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Credit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Cash on hand\"}}},{\"Id\":\"3\",\"Description\":\"Sample Transaction\",\"Amount\":123.45,\"DetailType\":\"JournalEntryLineDetail\",\"JournalEntryLineDetail\":{\"PostingType\":\"Debit\",\"AccountRef\":{\"value\":\"123\",\"name\":\"Opening Balance Equity\"}}}]},\"time\":\"2019-10-13T13:28:14.170-07:00\"}",
        headers: {}
      )
  end
end
