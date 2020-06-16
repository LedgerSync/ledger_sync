# frozen_string_literal: true

module StripeHelpers
  def stripe_client
    LedgerSync.ledgers.stripe.new(
      api_key: 'api_key'
    )
  end

  def stub_customer_create
    stub_request(:post, 'https://api.stripe.com/v1/customers')
      .with(
        body: { 'email' => 'test@example.com', 'metadata' => { 'external_id' => 'ext_id' }, 'name' => 'Sample Customer', 'phone' => '' },
        headers: stripe_request_headers
      ).to_return(status: 200, body: {
        "id": 'cus_123',
        "object": 'customer',
        "address": nil,
        "balance": 0,
        "created": 1_573_659_381,
        "currency": 'usd',
        "default_source": nil,
        "delinquent": false,
        "description": nil,
        "discount": nil,
        "email": nil,
        "invoice_prefix": '13B168D',
        "invoice_settings": {
          "custom_fields": nil,
          "default_payment_method": nil,
          "footer": nil
        },
        "livemode": false,
        "metadata": {
          "external_id": 'ext_id'
        },
        "name": nil,
        "phone": nil,
        "preferred_locales": [],
        "shipping": nil,
        "sources": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/sources'
        },
        "subscriptions": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/subscriptions'
        },
        "tax_exempt": 'none',
        "tax_ids": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/tax_ids'
        },
        "tax_info": nil,
        "tax_info_verification": nil
      }.to_json, headers: {})
  end

  def stub_customer_find
    stub_request(:get, 'https://api.stripe.com/v1/customers/cus_123')
      .with(
        body: {},
        headers: stripe_request_headers
      ).to_return(status: 200, body: {
        "id": 'cus_123',
        "object": 'customer',
        "address": nil,
        "balance": 0,
        "created": 1_573_659_381,
        "currency": 'usd',
        "default_source": nil,
        "delinquent": false,
        "description": nil,
        "discount": nil,
        "email": nil,
        "invoice_prefix": '13B168D',
        "invoice_settings": {
          "custom_fields": nil,
          "default_payment_method": nil,
          "footer": nil
        },
        "livemode": false,
        "metadata": {},
        "name": nil,
        "phone": nil,
        "preferred_locales": [],
        "shipping": nil,
        "sources": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/sources'
        },
        "subscriptions": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/subscriptions'
        },
        "tax_exempt": 'none',
        "tax_ids": {
          "object": 'list',
          "data": [],
          "has_more": false,
          "url": '/v1/customers/cus_GAjMZJUKS8I3Dm/tax_ids'
        },
        "tax_info": nil,
        "tax_info_verification": nil
      }.to_json, headers: {})
  end

  def stripe_request_headers
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => 'Bearer api_key',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'User-Agent' => %r{Stripe/v1 RubyBindings/[0-9]+\.[0-9]+\.[0-9]+},
      'X-Stripe-Client-User-Agent' => /.*/
    }
  end
end
