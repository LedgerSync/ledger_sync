# frozen_string_literal: true

module StripeHelpers
  def stripe_adaptor
    LedgerSync.adaptors.stripe.new(
      api_key: 'api_key'
    )
  end

  def stub_customer_create
    stub_request(:post, 'https://api.stripe.com/v1/customers')
      .with(
        body: { 'email' => 'test@example.com', 'name' => 'Sample Customer' },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer api_key',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'Stripe/v1 RubyBindings/5.8.0',
          'X-Stripe-Client-User-Agent' => '{"bindings_version":"5.8.0","lang":"ruby","lang_version":"2.6.3 p62 (2019-04-16)","platform":"x86_64-darwin18","engine":"ruby","publisher":"stripe","uname":"Darwin ryMac 18.7.0 Darwin Kernel Version 18.7.0: Sat Oct 12 00:02:19 PDT 2019; root:xnu-4903.278.12~1/RELEASE_X86_64 x86_64","hostname":"ryMac"}'
        }
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

  def stub_customer_find
    stub_request(:get, 'https://api.stripe.com/v1/customers/cus_123')
      .with(
        body: {},
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer api_key',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'Stripe/v1 RubyBindings/5.8.0',
          'X-Stripe-Client-User-Agent' => '{"bindings_version":"5.8.0","lang":"ruby","lang_version":"2.6.3 p62 (2019-04-16)","platform":"x86_64-darwin18","engine":"ruby","publisher":"stripe","uname":"Darwin ryMac 18.7.0 Darwin Kernel Version 18.7.0: Sat Oct 12 00:02:19 PDT 2019; root:xnu-4903.278.12~1/RELEASE_X86_64 x86_64","hostname":"ryMac"}'
        }
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
end
