module QuickbooksHelpers
  def stub_get_customer
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
end