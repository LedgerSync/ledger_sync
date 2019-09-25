module QuickbooksHelpers

  # Adaptor

  def stub_adaptor_refresh
    stub_request(:post, "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer").
    with(
      body: {"client_id"=>"client_id", "client_secret"=>"client_secret", "grant_type"=>"refresh_token", "refresh_token"=>"refresh_token"},
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/x-www-form-urlencoded',
      'User-Agent'=>'Faraday v0.15.4'
      }).
    to_return(
      status: 200,
      body: "{\"token_type\":\"bearer\",\"expires_in\":3600,\"refresh_token\":\"NEW_REFRESH_TOKEN\",\"x_refresh_token_expires_in\":1569480516,\"access_token\":\"NEW_ACCESS_TOKEN\"}",
      headers: {
        'Content-Type'=>'application/json'
      }
    )
  end

  # Customer

  def stub_create_customer
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer").
      with(
        body: "{\"DisplayName\":\"Sample Customer\",\"PrimaryPhone\":{\"FreeFormNumber\":null},\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Customer\":{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"}}}",
        headers: {}
      )
  end

  def stub_find_customer
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Customer\":{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"}}}",
        headers: {}
      )
  end

  def stub_search_customer
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Customer%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Customer%25'%20STARTPOSITION%201%20MAXRESULTS%2010").      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"QueryResponse\":{\"Customer\":[{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"}}]}}",
        headers: {}
      )
  end

  def stub_update_customer
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer").
      with(
        body: "{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"},\"PrimaryPhone\":{\"FreeFormNumber\":null}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Customer\":{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"}}}",
        headers: {}
      )
  end

  # Payment

  def stub_create_payment
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment").
      with(
        body: "{\"TotalAmt\":12345,\"CurrencyRef\":{\"value\":\"usd\"},\"CustomerRef\":{\"value\":\"66\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Payment\":{\"CustomerRef\":{\"value\":\"66\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"TotalAmt\":12345.0,\"UnappliedAmt\":12345.0,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"148\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"Line\":[]}}",
        headers: {}
      )
  end

  def stub_find_payment
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Payment\":{\"CustomerRef\":{\"value\":\"66\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"TotalAmt\":12345.0,\"UnappliedAmt\":12345.0,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"148\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"Line\":[]}}",
        headers: {}
      )
  end

  def stub_update_payment
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/payment").
      with(
        body: "{\"CustomerRef\":{\"value\":\"66\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"TotalAmt\":12345.0,\"UnappliedAmt\":12345.0,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"148\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"CurrencyRef\":{\"value\":\"usd\",\"name\":\"United States Dollar\"},\"Line\":[]}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Payment\":{\"CustomerRef\":{\"value\":\"66\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"TotalAmt\":12345.0,\"UnappliedAmt\":12345.0,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"148\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"Line\":[]}}",
        headers: {}
      )
  end

  # Vendor

  def stub_create_vendor
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor").
      with(
        body: "{\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Vendor\":{\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:03:28-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:03:28-07:00\"},\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"DisplayName\":\"Sample Vendor\",\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}},\"time\":\"2019-09-12T09:03:28.905-07:00\"}",
        headers: {}
      )
  end

  def stub_find_vendor
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Vendor\":{\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:05:52-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:05:52-07:00\"},\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"DisplayName\":\"Sample Vendor\",\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}},\"time\":\"2019-09-12T09:06:41.852-07:00\"}",
        headers: {}
      )
  end

  def stub_search_vendor
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Vendor%20WHERE%20DisplayName%20LIKE%20'%25Sample%20Vendor%25'%20STARTPOSITION%201%20MAXRESULTS%2010").      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"QueryResponse\":{\"Vendor\":[{\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:05:52-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:05:52-07:00\"},\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"DisplayName\":\"Sample Vendor\",\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}]}}",
        headers: {}
      )
  end

  def stub_update_vendor
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/vendor").
      with(
        body: "{\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:05:52-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:05:52-07:00\"},\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"DisplayName\":\"Sample Vendor\",\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Vendor\":{\"Balance\":0,\"Vendor1099\":false,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"1\",\"MetaData\":{\"CreateTime\":\"2019-09-12T09:05:52-07:00\",\"LastUpdatedTime\":\"2019-09-12T09:06:44-07:00\"},\"GivenName\":\"Sample\",\"FamilyName\":\"Vendor\",\"DisplayName\":\"Sample Vendor\",\"PrintOnCheckName\":\"Sample Vendor\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}},\"time\":\"2019-09-12T09:06:44.249-07:00\"}",
        headers: {}
      )
  end

  # Account

  def stub_create_account
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account").
      with(
        body: "{\"Name\":\"Sample Account\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"AcctNum\":null,\"CurrencyRef\":{\"value\":\"USD\"},\"Description\":\"This is Sample Account\",\"Active\":true}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Account\":{\"Name\":\"Sample Account\",\"SubAccount\":false,\"FullyQualifiedName\":\"Sample Account\",\"Active\":true,\"Classification\":\"Asset\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"CurrentBalance\":0,\"CurrentBalanceWithSubAccounts\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T12:22:16-07:00\",\"LastUpdatedTime\":\"2019-09-12T12:22:16-07:00\"}},\"time\":\"2019-09-12T12:22:16.650-07:00\"}",
        headers: {}
      )
  end

  def stub_find_account
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Account\":{\"Name\":\"Sample Account\",\"SubAccount\":false,\"FullyQualifiedName\":\"Sample Account\",\"Active\":true,\"Classification\":\"Asset\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"CurrentBalance\":0,\"CurrentBalanceWithSubAccounts\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T12:22:16-07:00\",\"LastUpdatedTime\":\"2019-09-12T12:22:16-07:00\"}},\"time\":\"2019-09-12T12:34:00.276-07:00\"}",
        headers: {}
      )
  end

  def stub_search_account
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/query?query=SELECT%20*%20FROM%20Account%20WHERE%20Name%20LIKE%20'%25Sample%20Account%25'%20STARTPOSITION%201%20MAXRESULTS%2010").      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"QueryResponse\":{\"Account\":[{\"Name\":\"Sample Account\",\"SubAccount\":false,\"FullyQualifiedName\":\"Sample Account\",\"Active\":true,\"Classification\":\"Asset\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"CurrentBalance\":0,\"CurrentBalanceWithSubAccounts\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T12:22:16-07:00\",\"LastUpdatedTime\":\"2019-09-12T12:22:16-07:00\"}}]}}",
        headers: {}
      )
  end

  def stub_update_account
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/account").
      with(
        body: "{\"Name\":\"Sample Account\",\"SubAccount\":false,\"FullyQualifiedName\":\"Sample Account\",\"Active\":true,\"Classification\":\"Asset\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"CurrentBalance\":0,\"CurrentBalanceWithSubAccounts\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T12:22:16-07:00\",\"LastUpdatedTime\":\"2019-09-12T12:22:16-07:00\"},\"AcctNum\":null,\"Description\":\"This is Sample Account\"}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Account\":{\"Name\":\"Sample\",\"SubAccount\":false,\"FullyQualifiedName\":\"Sample\",\"Active\":true,\"Classification\":\"Asset\",\"AccountType\":\"Bank\",\"AccountSubType\":\"CashOnHand\",\"CurrentBalance\":0,\"CurrentBalanceWithSubAccounts\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"123\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-12T12:22:16-07:00\",\"LastUpdatedTime\":\"2019-09-12T12:22:16-07:00\"}},\"time\":\"2019-09-12T12:36:42.241-07:00\"}",
        headers: {}
      )
  end

  # Expense

  def stub_create_expense
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase").
      with(
        body: "{\"CurrencyRef\":{\"value\":\"usd\"},\"PaymentType\":\"Cash\",\"TxnDate\":\"2019-09-01\",\"PrivateNote\":\"Memo\",\"ExchangeRate\":1.0,\"EntityRef\":{\"value\":\"123\"},\"AccountRef\":{\"value\":\"123\"},\"Line\":[{\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":12345,\"Description\":\"Sample Transaction\"},{\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\"}},\"Amount\":12345,\"Description\":\"Sample Transaction\"}]}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Purchase\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"PaymentType\":\"Cash\",\"EntityRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\",\"type\":\"Vendor\"},\"TotalAmt\":24690.0,\"PurchaseEx\":{\"any\":[{\"name\":\"{http://schema.intuit.com/finance/v3}NameValue\",\"declaredType\":\"com.intuit.schema.finance.v3.NameValue\",\"scope\":\"javax.xml.bind.JAXBElement$GlobalScope\",\"value\":{\"Name\":\"TxnType\",\"Value\":\"54\"},\"nil\":false,\"globalScope\":true,\"typeSubstituted\":false}]},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"151\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-20T09:44:50-07:00\",\"LastUpdatedTime\":\"2019-09-20T09:44:50-07:00\"},\"CustomField\":[],\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}]},\"time\":\"2019-09-20T09:44:50.133-07:00\"}",
        headers: {}
      )
  end

  def stub_find_expense
    stub_request(:get, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase/123").
      with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Purchase\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"PaymentType\":\"Cash\",\"EntityRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\",\"type\":\"Vendor\"},\"TotalAmt\":24690.0,\"PurchaseEx\":{\"any\":[{\"name\":\"{http://schema.intuit.com/finance/v3}NameValue\",\"declaredType\":\"com.intuit.schema.finance.v3.NameValue\",\"scope\":\"javax.xml.bind.JAXBElement$GlobalScope\",\"value\":{\"Name\":\"TxnType\",\"Value\":\"54\"},\"nil\":false,\"globalScope\":true,\"typeSubstituted\":false}]},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"151\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-20T09:44:50-07:00\",\"LastUpdatedTime\":\"2019-09-20T09:44:50-07:00\"},\"CustomField\":[],\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}]},\"time\":\"2019-09-20T09:44:50.133-07:00\"}",
        headers: {}
      )
  end

  def stub_update_expense
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/purchase").
      with(
        body: "{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"PaymentType\":\"Cash\",\"EntityRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\",\"type\":\"Vendor\"},\"TotalAmt\":24690.0,\"PurchaseEx\":{\"any\":[{\"name\":\"{http://schema.intuit.com/finance/v3}NameValue\",\"declaredType\":\"com.intuit.schema.finance.v3.NameValue\",\"scope\":\"javax.xml.bind.JAXBElement$GlobalScope\",\"value\":{\"Name\":\"TxnType\",\"Value\":\"54\"},\"nil\":false,\"globalScope\":true,\"typeSubstituted\":false}]},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"151\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-20T09:44:50-07:00\",\"LastUpdatedTime\":\"2019-09-20T09:44:50-07:00\"},\"CustomField\":[],\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"usd\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}],\"ExchangeRate\":1.0}",
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer access_token',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.15.4'
        }).
      to_return(
        status: 200,
        body: "{\"Purchase\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"PaymentType\":\"Cash\",\"EntityRef\":{\"value\":\"123\",\"name\":\"Sample Vendor\",\"type\":\"Vendor\"},\"TotalAmt\":24690.0,\"PurchaseEx\":{\"any\":[{\"name\":\"{http://schema.intuit.com/finance/v3}NameValue\",\"declaredType\":\"com.intuit.schema.finance.v3.NameValue\",\"scope\":\"javax.xml.bind.JAXBElement$GlobalScope\",\"value\":{\"Name\":\"TxnType\",\"Value\":\"54\"},\"nil\":false,\"globalScope\":true,\"typeSubstituted\":false}]},\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"151\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-09-20T09:44:50-07:00\",\"LastUpdatedTime\":\"2019-09-20T09:44:50-07:00\"},\"CustomField\":[],\"TxnDate\":\"2019-09-01\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PrivateNote\":\"Memo\",\"Line\":[{\"Id\":\"1\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}},{\"Id\":\"2\",\"Description\":\"Sample Transaction\",\"Amount\":12345.0,\"DetailType\":\"AccountBasedExpenseLineDetail\",\"AccountBasedExpenseLineDetail\":{\"AccountRef\":{\"value\":\"123\",\"name\":\"Sample Account\"},\"BillableStatus\":\"NotBillable\",\"TaxCodeRef\":{\"value\":\"NON\"}}}]},\"time\":\"2019-09-20T09:44:50.133-07:00\"}",
        headers: {}
      )
  end
end