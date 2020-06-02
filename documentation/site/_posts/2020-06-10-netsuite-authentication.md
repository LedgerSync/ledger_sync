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

## Options for Authentication

The REST API offers two types of authentication:  Token-Based Authentication (TBA) and OAuth 2.0.  We chose to use TBA, and you can read about our decision in our other blog post.

Simply put, TBA is based on OAuth 1.0. Ultimately, you need to generate a request header that includes a signature created using tokens retrieved from the NetSuite dashboard and the OAuth 1.0 standard.  Unfortunately, at the time of development, we hit a few walls trying to authenticate:

- The NetSuite documentation was only for their SOAP API and RESTlets
- There were no examples in Ruby
- Code samples relied on libraries or packages, making it hard to understand what was actually happening under the hood.
- There were very few examples that had both inputs and signature output to test against.

In the end, the challenge of authenticating to NetSuite in the REST API was computing the signature.  No examples we found worked for us, and regardless, we needed it in Ruby.  Frustratingly, the only way to know if we were correct was to try API calls after making tweaks to our signature generation algorithm.

If you’re reading this post, hopefully this will save you a headache or two.  We will clearly lay out our solution, break it down step-by-step, and we will give you some real examples.  Let’s get going!

Our Solution

Let’s start with the full solution, which can be found in the LedgerSync library class `LedgerSync::Ledgers::NetSuite::Token` (code can be found here).  The Token handles creating the authorization header that will be used to sign the request.  The request header looks something like this:

```
OAuth realm="TEST_REALM",oauth_consumer_key="ef40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4",oauth_token="2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc",oauth_signature_method="HMAC-SHA256",oauth_timestamp="1508242306",oauth_nonce="fjaLirsIcCGVZWzBX0pg",oauth_version="1.0",oauth_signature="i7MEtGwhCTIZbTsTrNGw9LdcERn4wsjt5C7TxmKWIfU%3D"
```

## The Inputs

To compute a signature, we need a few things first.  Let’s walk through each one and how to find it:

### Request Body
This is the body of the request that you intend to send to the API.

### Request URL
This is the URL of the request, which must include any query string parameters you intend to pass.

### OAuth Consumer Key & Secret
The consumer key and secret can be retrieved from NetSuite by creating an Integration Record.  Note that these values are only shown once at the end of creating a new Integration Record.  Once you navigate away, you will no longer be able to see these values.  You can reset the key and secret on existing Integration Records should you need to generate a new pair.

### OAuth Signature Method
NetSuite supports multiple signature methods.  Our library uses HMAC-SHA256.

### OAuth Timestamp
We need to include a current timestamp in the signature and header.

### OAuth Nonce
We need to include a random alphanumeric string to be used in the signature and header.

### OAuth Version
This is set to “1.0”

### Realm
The realm is the

Generating the Header
Ultimately, we need to produce a header
Computing the Signature
Go though step-by-step with inputs and outputs
Building the Header
Final Result
While not difficult in practice, it was by trial-and-error that we were able to determine exactly how to authenticate to NetSuite
Re-usable ruby examples
