# frozen_string_literal: true

require_relative 'quickbooks_online/record_collection'

module QuickBooksOnlineHelpers # rubocop:disable Metrics/ModuleLength
  def api_url(record:, ledger_id: nil)
    resource_class = "LedgerSync::Ledgers::QuickBooksOnline::#{record.ledger_class}".constantize
    url_resource = LedgerSync::Ledgers::QuickBooksOnline::Client.ledger_resource_type_for(
      resource_class: resource_class
    ).tr('_', '')

    ret = "https://sandbox-quickbooks.api.intuit.com/v3/company/realm_id/#{url_resource}"
    ret += '/' if url_resource == 'preferences' && !ret.end_with?('/')

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
    "Basic #{Base64.strict_encode64("#{client_id}:#{client_secret}")}"
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

  # Expense

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
