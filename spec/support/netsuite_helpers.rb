# frozen_string_literal: true

module NetSuiteHelpers
  # Auto-generates stub methods and helpers
  STUBBED_RESOURCES = {
    account: {
      id: 417,
      ledger_body: {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/account/417'
          }
        ],
        "acctname": 'CAD Account',
        "acctnumber": '1010',
        "accttype": 'Bank',
        "cashflowrate": 'AVERAGE',
        "currency": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/currency/3'
            }
          ],
          "id": '3',
          "refName": 'Canadian Dollar'
        },
        "eliminate": false,
        "generalrate": 'CURRENT',
        "id": '417',
        "includechildren": false,
        "inventory": false,
        "isinactive": false,
        "localizations": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/account/417/localizations'
            }
          ]
        },
        "revalue": true,
        "subsidiary": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/account/417/subsidiary'
            }
          ]
        }
      }
    },
    currency: {
      id: 2,
      ledger_body: {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/currency/2'
          }
        ],
        "currencyPrecision": 2,
        "displaySymbol": '£',
        "exchangeRate": 1.3037,
        "id": '2',
        "includeInFxRateUpdates": true,
        "isBaseCurrency": false,
        "isInactive": false,
        "name": 'British pound',
        "overrideCurrencyFormat": false,
        "symbol": 'GBP',
        "symbolPlacement": '1'
      }
    },
    customer: {
      id: 1137,
      ledger_body: { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137' }], 'addressbook' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137/addressbook' }] }, 'alcoholRecipientType' => 'CONSUMER', 'balance' => 0.0, 'companyName' => 'Company 1575890547', 'creditCards' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137/creditCards' }] }, 'creditholdoverride' => 'AUTO', 'currency' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/currency/1' }], 'id' => '1', 'refName' => 'USA' }, 'currencyList' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137/currencyList' }] }, 'custentity_atlas_help_entity_lp_ref' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customrecord_atlas_help_reference/4' }], 'id' => '4', 'refName' => 'Order to Cash' }, 'custentity_esc_last_modified_date' => '2019-12-09', 'customForm' => '30', 'dateCreated' => '2019-12-09T11:22:00Z', 'depositbalance' => 0.0, 'email' => 'customer@company.com', 'emailPreference' => 'DEFAULT', 'emailTransactions' => false, 'entityId' => 'Company 1575890547', 'entityStatus' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customerstatus/13' }], 'id' => '13', 'refName' => 'CUSTOMER-Closed Won' }, 'faxTransactions' => false, 'grouppricing' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137/grouppricing' }] }, 'id' => '1137', 'isBudgetApproved' => false, 'isinactive' => false, 'isPerson' => false, 'itempricing' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/customer/1137/itempricing' }] }, 'language' => 'en_US', 'lastModifiedDate' => '2019-12-09T11:22:00Z', 'overduebalance' => 0.0, 'printTransactions' => false, 'receivablesaccount' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/account/-10' }], 'id' => '-10', 'refName' => 'Use System Preference' }, 'shipComplete' => false, 'shippingCarrier' => 'nonups', 'subsidiary' => { 'links' => [{ 'rel' => 'self', 'href' => 'https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/subsidiary/2' }], 'id' => '2', 'refName' => 'Modern Treasury' }, 'taxable' => false, 'unbilledorders' => 0.0 }
    },
    department: {
      id: 7,
      ledger_body: {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/department/7'
          }
        ],
        "name": 'Engineering',
        "id": '7',
        "isinactive": false,
        "includechildren": false
      }
    }
  }.freeze

  def authorized_headers(override = {}, write: false)
    if write
      override = override.merge(
        'Content-Type' => 'application/json',
        'Host' => 'netsuite_account_id.suitetalk.api.netsuite.com'
      )
    end

    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => /OAuth realm="netsuite_account_id",oauth_consumer_key="NETSUITE_CONSUMER_KEY",oauth_token="NETSUITE_TOKEN_ID",oauth_signature_method="HMAC-SHA256",oauth_timestamp="[0-9]+",oauth_nonce="[0-9a-zA-Z]+",oauth_version="1.0",oauth_signature=".+"/,
      'User-Agent' => /.*/
    }.merge(override)
  end

  def api_record_url(record:, id: nil, **params)
    ret = "https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/#{record}"

    if id.present?
      ret += '/' unless ret.end_with?('/')
      ret += id.to_s
    end

    if params.present?
      uri = URI(ret)
      uri.query = params.to_query
      ret = uri.to_s
    end

    ret
  end

  def netsuite_adaptor(env: false)
    env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
    LedgerSync.adaptors.netsuite.new(
      account_id: env ? ENV.fetch('NETSUITE_ACCOUNT_ID', 'netsuite_account_id') : 'netsuite_account_id',
      consumer_key: env ? ENV.fetch('NETSUITE_CONSUMER_KEY', 'NETSUITE_CONSUMER_KEY') : 'NETSUITE_CONSUMER_KEY',
      consumer_secret: env ? ENV.fetch('NETSUITE_CONSUMER_SECRET', 'NETSUITE_CONSUMER_SECRET') : 'NETSUITE_CONSUMER_SECRET',
      token_id: env ? ENV.fetch('NETSUITE_TOKEN_ID', 'NETSUITE_TOKEN_ID') : 'NETSUITE_TOKEN_ID',
      token_secret: env ? ENV.fetch('NETSUITE_TOKEN_SECRET', 'NETSUITE_TOKEN_SECRET') : 'NETSUITE_TOKEN_SECRET'
    )
  end

  def stub_create(id:, url:)
    stub_request(:post, url)
      .with(
        headers: authorized_headers(write: true)
      )
      .to_return(
        status: 200,
        body: '',
        headers: {
          'Location': "#{url}/#{id}"
        }
      )
  end

  def stub_delete(url:)
    stub_request(:delete, url)
      .with(
        headers: authorized_headers
      )
      .to_return(
        status: 204,
        body: '',
        headers: {}
      )
  end

  def stub_find(response_body:, url:)
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_body)
      )
  end

  def stub_search(count: 2, starting_id:, url:)
    items = []
    count.times do |n|
      new_id = (starting_id.to_i + n).to_s
      items << {
        "links": [
          {
            "rel": 'self',
            "href": "#{url}/#{new_id}"
          }
        ],
        "id": new_id
      }
    end

    body = {
      "links": [
        {
          "rel": 'next',
          "href": "#{url}?limit=2&offset=2"
        },
        {
          "rel": 'last',
          "href": "#{url}?limit=2&offset=64"
        },
        {
          "rel": 'self',
          "href": "#{url}?limit=2&offset=0"
        }
      ],
      "count": count,
      "hasMore": true,
      "items": items,
      "offset": 0,
      "totalResults": 65
    }

    stub_request(:get, url)
      .to_return(
        status: 200,
        body: body.to_json
      )
  end

  def stub_update(url:)
    stub_request(:patch, url)
      .with(
        headers: authorized_headers(write: true)
      )
      .to_return(
        status: 200,
        body: '',
        headers: {
          'Location': url
        }
      )
  end

  # Dynamically define helpers

  STUBBED_RESOURCES.each do |record, opts|
    url_method_name = "#{record}_url"
    define_method(url_method_name) do |**keywords|
      api_record_url(
        **{
          record: record
        }.merge(keywords)
      )
    end

    define_method("stub_#{record}_create") do
      stub_create(
        id: opts[:id],
        url: send(url_method_name)
      )
    end

    define_method("stub_#{record}_delete") do
      stub_delete(
        url: send(url_method_name, id: opts[:id])
      )
    end

    define_method("stub_#{record}_find") do
      stub_find(
        response_body: opts[:ledger_body],
        url: send(url_method_name, id: opts[:id])
      )
    end

    define_method("stub_#{record}_search") do
      stub_search(
        starting_id: opts[:id],
        url: send(url_method_name, limit: 10, offset: 0)
      )
    end

    define_method("stub_#{record}_update") do
      stub_update(
        url: send(url_method_name, id: opts[:id])
      )
    end
  end
end
