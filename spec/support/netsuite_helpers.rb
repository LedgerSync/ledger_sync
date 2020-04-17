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
    },
    invoice: {
      id: '1227',
      ledger_body: {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227'
          }
        ],
        "amountpaid": 0.0,
        "amountremaining": 2010.0,
        "amountremainingtotalbox": 2010.0,
        "balance": 1910.0,
        "billingaddress": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/billingaddress'
            }
          ]
        },
        "canHaveStackable": false,
        "createdDate": '2020-04-07T11:53:00Z',
        "currency": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/currency/1'
            }
          ],
          "id": '1',
          "refName": 'USA'
        },
        "currencyName": 'USA',
        "currencysymbol": 'USD',
        "custbody_atlas_exist_cust_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_cust_type/2'
            }
          ],
          "id": '2',
          "refName": 'Existing Customer'
        },
        "custbody_atlas_help_trans_lp_ref": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customrecord_atlas_help_reference/4'
            }
          ],
          "id": '4',
          "refName": 'Order to Cash'
        },
        "custbody_atlas_new_cust_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_cust_type/1'
            }
          ],
          "id": '1',
          "refName": 'New Customer'
        },
        "custbody_atlas_no_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_appr_by_creator/2'
            }
          ],
          "id": '2',
          "refName": 'No'
        },
        "custbody_atlas_yes_hdn": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customlist_atlas_appr_by_creator/1'
            }
          ],
          "id": '1',
          "refName": 'Yes'
        },
        "custbody_esc_created_date": '2020-04-07',
        "custbody_esc_last_modified_date": '2020-04-07',
        "customForm": '131',
        "discountTotal": 0.0,
        "email": 'ryan-test-co@example.com',
        "entity": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/7938'
            }
          ],
          "id": '7938',
          "refName": 'Ryan Test Co.'
        },
        "entityNexus": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/nexus/2'
            }
          ],
          "id": '2',
          "refName": 'CA'
        },
        "estGrossProfit": 2010.0,
        "estGrossProfitPercent": 100.0,
        "exchangeRate": 1.0,
        "id": '1227',
        "isBaseCurrency": true,
        "isTaxable": false,
        "item": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/item'
            }
          ]
        },
        "lastModifiedDate": '2020-04-07T13:34:00Z',
        "location": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/location/1'
            }
          ],
          "id": '1',
          "refName": 'Modern Treasury'
        },
        "nexus": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/nexus/2'
            }
          ],
          "id": '2',
          "refName": 'CA'
        },
        "postingperiod": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/accountingperiod/20'
            }
          ],
          "id": '20',
          "refName": 'Jan 2018'
        },
        "saleseffectivedate": '2020-04-06',
        "shipDate": '2020-04-06',
        "shipIsResidential": false,
        "shipOverride": false,
        "shippingAddress": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/invoice/1227/shippingAddress'
            }
          ]
        },
        "status": 'Open',
        "subsidiary": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/subsidiary/2'
            }
          ],
          "id": '2',
          "refName": 'Modern Treasury'
        },
        "subtotal": 2010.0,
        "taxItem": {
          "links": [],
          "id": '-7',
          "refName": '-Not Taxable-'
        },
        "taxRate": 0.0,
        "toBeEmailed": false,
        "toBeFaxed": false,
        "toBePrinted": false,
        "total": 2010.0,
        "totalCostEstimate": 0.0,
        "trandate": '2020-04-06',
        "tranId": 'INV01'
      }
    },
    location: {
      id: 1137,
      ledger_body: {
        "links": [
          {
            "rel": 'self',
            "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/location/1'
          }
        ],
        "id": '1137',
        "isinactive": false,
        "makeinventoryavailable": true,
        "name": 'Modern Treasury',
        "subsidiary": {
          "links": [
            {
              "rel": 'self',
              "href": 'https://5743578-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/location/1/subsidiary'
            }
          ]
        },
        "timezone": 'America/Los_Angeles'
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

  def api_record_url(args = {})
    record = args.fetch(:record)
    id = args.fetch(:id, nil)
    params = args.fetch(:params, {})

    ret = "https://netsuite_account_id.suitetalk.api.netsuite.com/services/rest/record/v1/#{record}"

    if id.present?
      ret += '/' unless ret.end_with?('/')
      ret += id.to_s
    end

    LedgerSync::Adaptors::Request.merge_params(
      params: params,
      url: ret
    )
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

  def stub_create_for_record
    send("stub_#{record}_create")
  end

  def stub_create_request(id:, url:)
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

  def stub_delete_for_record
    send("stub_#{record}_delete")
  end

  def stub_delete_request(url:)
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

  def stub_find_for_record
    send("stub_#{record}_find")
  end

  def stub_find_request(response_body:, url:)
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_body)
      )
  end

  def stub_search_for_record
    send("stub_#{record}_search")
  end

  def stub_search_request(count: 2, starting_id:, url:)
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

  def stub_update_for_record
    send("stub_#{record}_update")
  end

  def stub_update_request(url:)
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
      stub_create_request(
        id: opts[:id],
        url: send(url_method_name)
      )
    end

    define_method("stub_#{record}_delete") do
      stub_delete_request(
        url: send(url_method_name, id: opts[:id])
      )
    end

    define_method("stub_#{record}_find") do
      stub_find_request(
        response_body: opts[:ledger_body],
        url: send(
          url_method_name,
          id: opts[:id],
          params: netsuite_adaptor.class::GLOBAL_REQUEST_PARAMS.fetch(:get, {})
        )
      )
    end

    define_method("stub_#{record}_search") do
      stub_search_request(
        starting_id: opts[:id],
        url: send(
          url_method_name,
          params: netsuite_adaptor.class::GLOBAL_REQUEST_PARAMS.fetch(:get, {}).merge(
            limit: 10,
            offset: 0
          )
        )
      )
    end

    define_method("stub_#{record}_update") do
      stub_update_request(
        url: send(url_method_name, id: opts[:id])
      )
    end
  end
end
