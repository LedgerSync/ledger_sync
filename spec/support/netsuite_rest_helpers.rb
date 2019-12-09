# frozen_string_literal: true

module NetSuiteRESTHelpers
  def authorized_headers(override = {})
    {
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => /OAuth realm="NETSUITE_REST_ACCOUNT_ID",oauth_consumer_key="NETSUITE_REST_CONSUMER_KEY",oauth_token="NETSUITE_REST_TOKEN_ID",oauth_signature_method="HMAC-SHA256",oauth_signature=".+",oauth_timestamp="[0-9]+",oauth_nonce="[0-9a-zA-Z]+",oauth_version="1.0"/,
      'User-Agent' => /Faraday v[0-9]+\.[0-9]+\.[0-9]+/
    }.merge(override)
  end

  def netsuite_rest_adaptor
    LedgerSync.adaptors.netsuite_rest.new(
      account_id: ENV.fetch('NETSUITE_REST_ACCOUNT_ID', 'NETSUITE_REST_ACCOUNT_ID'),
      consumer_key: ENV.fetch('NETSUITE_REST_CONSUMER_KEY', 'NETSUITE_REST_CONSUMER_KEY'),
      consumer_secret: ENV.fetch('NETSUITE_REST_CONSUMER_SECRET', 'NETSUITE_REST_CONSUMER_SECRET'),
      token_id: ENV.fetch('NETSUITE_REST_TOKEN_ID', 'NETSUITE_REST_TOKEN_ID'),
      token_secret: ENV.fetch('NETSUITE_REST_TOKEN_SECRET', 'NETSUITE_REST_TOKEN_SECRET')
    )
  end

  def stub_customer_find
    stub_request(:get, 'https://netsuite_rest_account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137')
      .with(
        headers: authorized_headers(
          'Accept' => '*/*'
        )
      )
      .to_return(
        status: 200,
        body: '{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137"}],"addressbook":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137/addressbook"}]},"alcoholRecipientType":"CONSUMER","balance":0.0,"companyName":"Company 1575890547","creditCards":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137/creditCards"}]},"creditholdoverride":"AUTO","currency":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/currency/1"}],"id":"1","refName":"USA"},"currencyList":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137/currencyList"}]},"custentity_atlas_help_entity_lp_ref":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customrecord_atlas_help_reference/4"}],"id":"4","refName":"Order to Cash"},"custentity_esc_last_modified_date":"2019-12-09","customForm":"30","dateCreated":"2019-12-09T11:22:00Z","depositbalance":0.0,"email":"customer@company.com","emailPreference":"DEFAULT","emailTransactions":false,"entityId":"Company 1575890547","entityStatus":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customerstatus/13"}],"id":"13","refName":"CUSTOMER-Closed Won"},"faxTransactions":false,"grouppricing":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137/grouppricing"}]},"id":"1137","isBudgetApproved":false,"isinactive":false,"isPerson":false,"itempricing":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/customer/1137/itempricing"}]},"language":"en_US","lastModifiedDate":"2019-12-09T11:22:00Z","overduebalance":0.0,"printTransactions":false,"receivablesaccount":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/account/-10"}],"id":"-10","refName":"Use System Preference"},"shipComplete":false,"shippingCarrier":"nonups","subsidiary":{"links":[{"rel":"self","href":"https://account_id.suitetalk.api.netsuite.com/rest/platform/v1/record/subsidiary/2"}],"id":"2","refName":"Modern Treasury"},"taxable":false,"unbilledorders":0.0}',
        headers: {}
      )
  end
end
