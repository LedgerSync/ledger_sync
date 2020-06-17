# frozen_string_literal: true

require_relative 'netsuite/record_collection'

# Define globally so it's only evaluated once.
NETSUITE_RECORD_COLLECTION = Test::NetSuite::RecordCollection.new

module NetSuiteHelpers # rubocop:disable Metrics/ModuleLength
  def authorized_headers(override = {}, write: false)
    if write
      override = override.merge(
        'Content-Type' => 'application/json',
        'Host' => 'netsuite-account-id.suitetalk.api.netsuite.com'
      )
    end

    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' =>
        /
        OAuth
        \s
        realm="NETSUITE_ACCOUNT_ID",
        oauth_consumer_key="NETSUITE_CONSUMER_KEY",
        oauth_token="NETSUITE_TOKEN_ID",
        oauth_signature_method="HMAC-SHA256",
        oauth_timestamp="[0-9]+",
        oauth_nonce="[0-9a-zA-Z]+",
        oauth_version="1.0",
        oauth_signature=".+"
        /x,
      'User-Agent' => /.*/
    }.merge(override)
  end

  def api_record_url(args = {})
    _record = args.fetch(:record)
    id      = args.fetch(:id, nil)
    params  = args.fetch(:params, {})

    resource_endpoint = netsuite_client.class.ledger_resource_type_for(resource_class: resource.class)
    ret = "https://netsuite-account-id.suitetalk.api.netsuite.com/services/rest/record/v1/#{resource_endpoint}"

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

  def env_account_id
    return ENV.fetch('NETSUITE_ACCOUNT_ID', 'netsuite_account_id') if netsuite_env?

    'netsuite_account_id'
  end

  def env_consumer_key
    return ENV.fetch('NETSUITE_CONSUMER_KEY', 'NETSUITE_CONSUMER_KEY') if netsuite_env?

    'NETSUITE_CONSUMER_KEY'
  end

  def env_consumer_secret
    return ENV.fetch('NETSUITE_CONSUMER_SECRET', 'NETSUITE_CONSUMER_SECRET') if netsuite_env?

    'NETSUITE_CONSUMER_SECRET'
  end

  def env_token_id
    return ENV.fetch('NETSUITE_TOKEN_ID', 'NETSUITE_TOKEN_ID') if netsuite_env?

    'NETSUITE_TOKEN_ID'
  end

  def env_token_secret
    return ENV.fetch('NETSUITE_TOKEN_SECRET', 'NETSUITE_TOKEN_SECRET') if netsuite_env?

    'NETSUITE_TOKEN_SECRET'
  end

  def netsuite_client
    LedgerSync.ledgers.netsuite.new(
      account_id: env_account_id,
      consumer_key: env_consumer_key,
      consumer_secret: env_consumer_secret,
      token_id: env_token_id,
      token_secret: env_token_secret
    )
  end

  def netsuite_env?
    @netsuite_env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
  end

  def netsuite_records
    @netsuite_records ||= Test::NetSuite::RecordCollection.new
  end

  def netsuite_resource_type
    record.to_s.gsub(/^netsuite_/, '')
  end

  def stub_create_for_record
    send("stub_#{netsuite_resource_type}_create")
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
    send("stub_#{netsuite_resource_type}_delete")
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

  def stub_find_for_record(params: {})
    send("stub_#{netsuite_resource_type}_find", params)
  end

  def stub_find_request(response_body:, url:)
    stub_request(:get, url)
      .to_return(
        status: 200,
        body: (response_body.is_a?(Hash) ? response_body.to_json : response_body)
      )
  end

  def stub_search_for_record
    send("stub_#{netsuite_resource_type}_search")
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

  def stub_update_for_record(params: {})
    send("stub_#{netsuite_resource_type}_update", params)
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
  NETSUITE_RECORD_COLLECTION.all.each do |record, opts|
    record = record.gsub('/', '_')
    url_method_name = "#{record}_url"

    if record.end_with?('_search')
      define_method("stub_#{record}") do
        stub_request(:post, 'https://netsuite-account-id.suitetalk.api.netsuite.com/services/rest/query/v1/suiteql?limit=10&offset=0')
          .to_return(
            status: 200,
            body: opts.hash.to_json
          )
      end
      next
    elsif record.end_with?('_metadata_properties')
      define_method("stub_#{record}") do
        stub_request(:get, 'https://netsuite-account-id.suitetalk.api.netsuite.com/rest/platform/v1/metadata-catalog/record/customer')
          .to_return(
            status: 200,
            body: opts.hash.to_json
          )
      end
      next
    elsif record.end_with?('_metadata')
      define_method("stub_#{record}") do
        stub_request(:get, 'https://netsuite-account-id.suitetalk.api.netsuite.com/services/rest/record/v1/metadata-catalog?select=customer')
          .to_return(
            status: 200,
            body: opts.hash.to_json
          )
      end
      next
    end

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
        url: send(
          url_method_name,
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_find") do |params = {}|
      stub_find_request(
        response_body: opts.hash,
        url: send(
          url_method_name,
          params: params.merge(
            expandSubResources: true
          ),
          id: opts.id
        )
      )
    end

    define_method("stub_#{record}_update") do |params = {}|
      stub_update_request(
        url: send(
          url_method_name,
          params: params,
          id: opts.id
        )
      )
    end
  end
end
