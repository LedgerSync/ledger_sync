# frozen_string_literal: true

require_relative 'netsuite/record_collection'

module NetSuiteHelpers
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

  def netsuite_records
    @netsuite_records ||= Test::NetSuite::RecordCollection.new
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

  byebug

  Test::NetSuite::RecordCollection.new.all.each do |record, opts|
    record = record.gsub('/', '_')
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
        id: opts.id,
        url: send(url_method_name)
      )
    end

    define_method("stub_#{record}_delete") do
      stub_delete_request(
        url: send(url_method_name, id: opts.id)
      )
    end

    define_method("stub_#{record}_find") do
      stub_find_request(
        response_body: opts.hash,
        url: send(url_method_name, id: opts.id)
      )
    end

    define_method("stub_#{record}_search") do
      stub_search_request(
        starting_id: opts.id,
        url: send(url_method_name, limit: 10, offset: 0)
      )
    end

    define_method("stub_#{record}_update") do
      stub_update_request(
        url: send(url_method_name, id: opts.id)
      )
    end
  end
end
