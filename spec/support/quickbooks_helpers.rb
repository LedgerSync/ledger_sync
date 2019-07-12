module QuickbooksHelpers

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

  def stub_update_customer
    stub_request(:post, "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/customer").
      with(
        body: "{\"Taxable\":true,\"Job\":false,\"BillWithParent\":false,\"Balance\":0,\"BalanceWithJobs\":0,\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"PreferredDeliveryMethod\":\"Print\",\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"66\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:04:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:04:17-07:00\"},\"FullyQualifiedName\":\"Sample Customer\",\"DisplayName\":\"Sample Customer\",\"PrintOnCheckName\":\"Sample Customer\",\"Active\":true,\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"},\"DefaultTaxCodeRef\":{\"value\":\"2\"},\"DisplayName\":\"Sample Customer\",\"PrimaryPhone\":{\"FreeFormNumber\":null},\"PrimaryEmailAddr\":{\"Address\":\"test@example.com\"}}",
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
        body: "{\"CustomerRef\":{\"value\":\"66\",\"name\":\"Sample Customer\"},\"DepositToAccountRef\":{\"value\":\"4\"},\"TotalAmt\":12345.0,\"UnappliedAmt\":12345.0,\"ProcessPayment\":false,\"domain\":\"QBO\",\"sparse\":false,\"Id\":\"148\",\"SyncToken\":\"0\",\"MetaData\":{\"CreateTime\":\"2019-07-11T13:54:17-07:00\",\"LastUpdatedTime\":\"2019-07-11T13:54:17-07:00\"},\"TxnDate\":\"2019-07-11\",\"CurrencyRef\":{\"value\":\"USD\",\"name\":\"United States Dollar\"},\"Line\":[],\"TotalAmt\":12345,\"CurrencyRef\":{\"value\":\"usd\"},\"CustomerRef\":{\"value\":\"66\"}}",
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
end