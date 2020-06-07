---
title: How to authenticate to NetSuite's SuiteTalk REST Web Services API
excerpt: >-
  A step-by-step guide to authenticating to the new NetSuite REST API.
date: '2020-06-01'
# thumb_image: images/4.jpg
# image: images/3.jpg
layout: post
---

Earlier this year, NetSuite released their new REST API called SuiteTalk REST Web Services.  While still incomplete, this API provides a much friendlier interface for developers than its predecessors— the SOAP API and RESTlets.  We chose to use the new REST API, because we believe it is the future for building integrations to NetSuite.  The REST standard is much more intuitive, with many resources across many languages and frameworks.

{% include alerts/info.html title="Tip:" content="We do our best to write comprehensive unit tests for the entire library.  Tests are a great resource for examples on inputs, outputs, and usage, not all of which may be documented here." %}

## Options for Authentication

The REST API offers two types of authentication:  Token-Based Authentication (TBA) and OAuth 2.0.  We chose to use TBA for the REST client.

Simply put, TBA is based on OAuth 1.0. Ultimately, you need to generate a request header that includes a signature created using tokens retrieved from the NetSuite dashboard and the OAuth 1.0 standard.  Unfortunately, at the time of development, we hit a few walls trying to authenticate:

- The NetSuite documentation was only for their SOAP API and RESTlets
- There were no examples in Ruby
- Code samples relied on libraries or packages, making it hard to understand what was actually happening under the hood.
- The nonce and timestamp were not defined in the inputs of examples we found, so outputs would naturally vary given that these values are meant to change in practice.
- There were very few examples that had both inputs and signature output to test against.

In the end, the challenge of authenticating to NetSuite in the REST API was computing the signature.  No examples we found worked for us, and regardless, we needed it in Ruby.  Frustratingly, the only way to know if we were correct was to try API calls after making tweaks to our signature generation algorithm.

If you’re reading this post, hopefully this will save you a headache or two.  We will clearly lay out our solution, break it down step-by-step, and we will give you some real examples.  Let’s get going!

## Our Solution

Let’s start with the full solution, which can be found in the LedgerSync library class `LedgerSync::Ledgers::NetSuite::Token` (code can be found here).  The Token handles creating the authorization header that will be used to sign the request.  The request header looks something like this:

```
Authorization: OAuth realm="TEST_REALM",oauth_consumer_key="ef40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4",oauth_token="2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc",oauth_signature_method="HMAC-SHA256",oauth_timestamp="1508242306",oauth_nonce="fjaLirsIcCGVZWzBX0pg",oauth_version="1.0",oauth_signature="i7MEtGwhCTIZbTsTrNGw9LdcERn4wsjt5C7TxmKWIfU%3D"
```

## The Inputs

To compute a signature, we need a few things first.  Let’s walk through each one and how to find it:

### `method`

The request method will be one of the following:

- `POST`
- `PUT`
- `PATCH`
- `GET`
- `DELETE`

### `consumer_key`, `consumer_secret`

The consumer key and secret can be retrieved from NetSuite by creating an Integration Record.  Note that these values are only shown once at the end of creating a new Integration Record.  Once you navigate away, you will no longer be able to see these values.  You can reset the key and secret on existing Integration Records should you need to generate a new pair.

### `signature_method`

NetSuite supports multiple signature methods.  Our library uses HMAC-SHA256.

### `timestamp`

We need to include a current timestamp in the signature and header.

### `nonce`

We need to include a random alphanumeric string to be used in the signature and header.

### `oauth_version`

The OAuth Version is defaults to “1.0”

### `realm`

The realm is the NetSuite account ID.  You can find this in your account or in the URL:

`https://<ACCOUNT_ID>.app.netsuite.com/app/center/card.nl`

If you are using a sandbox or test drive account, your account ID will include a hyphen and some other characters.  For example, it may look like this: `9876543-sb1`.

Once you have the account ID, we will need to transform it to the format the API expects.  You replace any hyphens with underscores (a.k.a. `_`) and capitalize all letters.  So `9876543-sb1` will become `9876543_SB1`.

### `token_id`, `token_secret`

These values can be found in NetSuite when you [create an Access Token](https://system.netsuite.com/app/setup/accesstokens.nl).  Like the Integration Record, these values are only visible at the end of creating the token and will not be shown again.  You can also reset these values on existing Access Tokens.

### `url`

This is the URL of the request, which must include any query string parameters you intend to pass.

## Example Values

For this guide, we will use the following values:

<div class="responsive-table">
  <table>
      <caption>Input values</caption>
    <thead>
      <tr>
        <th>Variable</th>
        <th>Value</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>method</code></td>
        <td><code>"GET"</code></td>
      </tr>
      <tr>
        <td><code>consumer_key</code></td>
        <td><code>"CONSUMER_KEY_VALUE"</code></td>
      </tr>
      <tr>
        <td><code>consumer_secret</code></td>
        <td><code>"CONSUMER_SECRET_VALUE"</code></td>
      </tr>
      <tr>
        <td><code>signature_method</code></td>
        <td>default, <code>"HMAC-SHA256"</code></td>
      </tr>
      <tr>
        <td><code>timestamp</code></td>
        <td>Typically, you will leave this empty, but we will use <code>1234567890</code></td>
      </tr>
      <tr>
        <td><code>nonce</code></td>
        <td>Typically, you will leave this empty, but we will use <code>"asdfasdf"</code></td>
      </tr>
      <tr>
        <td><code>oauth_version</code></td>
        <td>default, <code>"1.0"</code></td>
      </tr>
      <tr>
        <td><code>realm</code></td>
        <td><code>"9876543_SB1"</code></td>
      </tr>
      <tr>
        <td><code>token_id</code></td>
        <td><code>"TOKEN_ID_VALUE"</code></td>
      </tr>
      <tr>
        <td><code>token_secret</code></td>
        <td><code>"TOKEN_SECRET_VALUE"</code></td>
      </tr>
      <tr>
        <td><code>url</code></td>
        <td><code>"https://9876543-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/123?expandSubResources=true"</code></td>
      </tr>
    </tbody>
  </table>
</div>

{% capture default_values_note %}
The values for <code>nonce</code> and <code>timestamp</code> should be left <code>nil</code> or unpassed in practice.  They are included here for purposes of having a consistent input and output, where typically they would be generated on the fly.
{% endcapture %}

{% include alerts/info.html title="Note:" content=default_values_note %}

Throughout this tutorial, examples will appear in the following style.  You can copy and paste this code in sequence to get the same results.

{% capture example_content %}
```ruby
method = 'GET'
consumer_key = 'CONSUMER_KEY_VALUE'
consumer_secret = 'CONSUMER_SECRET_VALUE'
nonce = 'asdfasdf'
oauth_version = '1.0'
realm = '9876543_SB1'
signature_method = 'HMAC-SHA256'
timestamp = 1_234_567_890
token_id = 'TOKEN_ID_VALUE'
token_secret = 'TOKEN_SECRET_VALUE'
url = 'https://9876543-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/123?expandSubResources=true'
```
{% endcapture %}

{% include example.md content=example_content %}


## Generating the header

Now that we have our inputs, we can walk through computing the signature and header.

Before we dive in, please note that many values need to be escaped.  If you see `escape(...)` being used below, it is shorthand for the following:

```ruby
def escape(str)
  CGI.escape(str.to_s).gsub(/\+/, '%20')
end
```

Now let's walk through each step:

### 1. Build data string

We need to create a string that will be used to compute a digest (a.k.a. signature) from.  Using our values above, we can retrieve the string using the following:

{% capture example_content %}
```ruby
token = LedgerSync::Ledgers::NetSuite::Token.new(
  method: method,
  consumer_key: consumer_key,
  consumer_secret: consumer_secret,
  realm: realm,
  token_id: token_id,
  token_secret: token_secret,
  url: url
)

puts token.signature_data_string
```
{% endcapture %}

{% capture example_result %}
```ruby
"GET&https%3A%2F%2F9876543-sb1.suitetalk.api.netsuite.com%2Fservices%2Frest%2Frecord%2Fv1%2Fcustomer%2F123&expandSubResources%3Dtrue%26oauth_consumer_key%3DCONSUMER_KEY_VALUE%26oauth_nonce%3Dasdfasdf%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D1234567890%26oauth_token%3DTOKEN_ID_VALUE%26oauth_version%3D1.0"
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

But how is this created?  It is composed of three values that are escaped and joined with `&`.  The values are as follows:

- `method`: Described in the inputs above.
- `url_without_params`: The `url` with all query parameters removed.  In our example, this would be `https://9876543-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/123`
- `parameters_string`: A string representation of all URL parameters as well as the oauth parameters.

Let's dive a level deeper and look into creating the `parameters` string.

### 1a. Build parameters string

The parameters string is a sorted list of key/value pairs each joined with an ampersand (`&`).  The key/value pairs come from two sources:

- Query parameters parsed out of the URL, in our case `{ "expandSubResources" => "true }`
- OAuth parameters

For our example, we would have the following:

{% capture example_content %}
```ruby
url_params = {
  "expandSubResources" => "true"
}

oauth_parameters_array = {
  oauth_consumer_key: consumer_key,
  oauth_nonce: nonce,
  oauth_signature_method: signature_method,
  oauth_timestamp: timestamp,
  oauth_token: token_id,
  oauth_version: oauth_version
}.to_a

parameters_string = url_params.to_a
                              .concat(oauth_parameters_array)
                              .map { |k, v| [escape(k), escape(v)] }
                              .sort { |a, b| a <=> b }
                              .map { |e| "#{e[0]}=#{e[1]}" }
                              .join('&')

puts parameters_string
```
{% endcapture %}

{% capture example_result %}
```ruby
"expandSubResources=true&oauth_consumer_key=CONSUMER_KEY_VALUE&oauth_nonce=asdfasdf&oauth_signature_method=HMAC-SHA256&oauth_timestamp=1234567890&oauth_token=TOKEN_ID_VALUE&oauth_version=1.0"
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

### 1b. Put it together

Now that we have our `parameters_string`, we can generate the following:

{% capture example_content %}
```ruby
url_without_params = "https://9876543-sb1.suitetalk.api.netsuite.com/services/rest/record/v1/customer/123"

signature_data_string = [
  method,
  escape(url_without_params),
  escape(parameters_string)
].join('&')
```
{% endcapture %}

{% capture example_result %}
```ruby
"GET&https%3A%2F%2F9876543-sb1.suitetalk.api.netsuite.com%2Fservices%2Frest%2Frecord%2Fv1%2Fcustomer%2F123&expandSubResources%3Dtrue%26oauth_consumer_key%3DCONSUMER_KEY_VALUE%26oauth_nonce%3Dasdfasdf%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D1234567890%26oauth_token%3DTOKEN_ID_VALUE%26oauth_version%3D1.0"
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

## 2. Build signature key

The final piece needed to generate a signature is the key.  Our key is made by joining our `consumer_secret` to `token_secret` with an ampersand (`&`):

{% capture example_content %}
```ruby
key ||= [
  consumer_secret,
  token_secret
].join('&')
```
{% endcapture %}

{% capture example_result %}
```ruby
"CONSUMER_SECRET_VALUE&TOKEN_SECRET_VALUE"
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

## 3. Compute signature

Now with our `signature_data_string`, we will use the desired `signature_method` to compute a digest.  We will assume we are using `HMAC-SHA256`.

{% capture example_content %}
```ruby
signature ||= Base64.encode64(
  OpenSSL::HMAC.digest(
    OpenSSL::Digest.new('sha256'),
    key,
    signature_data_string
  )
).strip
```
{% endcapture %}

{% capture example_result %}
```ruby
"cId0B3hP0sFVQw/gjQ/P6YiOSx76u0WfyO8umOlq3gg="
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

## 4. Generate Header

Last but not least, we can now generate our header.  The header is made by combining all of the inputs and our signature together in comma-separated, key-value pairs:

{% capture example_content %}
```ruby
authorization_parts = [
  [:realm, realm],
  [:oauth_consumer_key, escape(consumer_key)],
  [:oauth_token, escape(token_id)],
  [:oauth_signature_method, signature_method],
  [:oauth_timestamp, timestamp],
  [:oauth_nonce, escape(nonce)],
  [:oauth_version, oauth_version],
  [:oauth_signature, escape(signature)]
]

headers = {
  'Authorization' => "OAuth #{authorization_parts.map { |k, v| "#{k}=\"#{v}\"" }.join(',')}"
}

puts headers
```

{% endcapture %}

{% capture example_result %}
```ruby
{"Authorization"=>"OAuth realm=\"9876543_SB1\",oauth_consumer_key=\"CONSUMER_KEY_VALUE\",oauth_token=\"TOKEN_ID_VALUE\",oauth_signature_method=\"HMAC-SHA256\",oauth_timestamp=\"1234567890\",oauth_nonce=\"asdfasdf\",oauth_version=\"1.0\",oauth_signature=\"cId0B3hP0sFVQw%2FgjQ%2FP6YiOSx76u0WfyO8umOlq3gg%3D\""}
```
{% endcapture %}

{% include example.md content=example_content result=example_result %}

## Wrapping up

All that is left is to use this header in a request.  You will need a new signature (and therefore new header) per-request.  And that's it!

While not difficult in practice, it was by trial-and-error we were ultimately able to authenticate to NetSuite.  Hopefully this post saves you some time!

It is highly recommended that you write comprehensive unit tests for this code.  We wrote some tests in RSpec.  These test are a great resource for examples you can test against.