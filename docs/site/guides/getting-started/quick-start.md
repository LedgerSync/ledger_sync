---
title: Quick Start
weight: 2
layout: guides
---

## Overview

To use LedgerSync, you must carry out an `Operation`.  The operation will be ledger-specific and will require the
following:

1. Client
2. Resource(s)

## 1. Create a client

Clients are responsible for the authentication and requests for a specific ledger.  In this example, we will assume you
are using the QuickBooks Online ledger.

<div class="note"><strong>Note:</strong> Each ledger has different requirements for authentication.  Please visit the
ledger-specific pages to learn more.</div>

```ruby
client = LedgerSync::Ledgers::QuickBooksOnline::Client.new(
  access_token: access_token, # assuming this is defined
  client_id: ENV['QUICKBOOKS_ONLINE_CLIENT_ID'],
  client_secret: ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'],
  realm_id: ENV['QUICKBOOKS_ONLINE_REALM_ID'],
  refresh_token: refresh_token # assuming this is defined
)
```

## 2. Create resource(s)

Create a resource on which to operate.  Some resources have references to other resources.  You can use
`Util::ResourcesBuilder` to create resources and relationships from a structured hash.

<div class="note"><strong>Note:</strong> Resources are ledger-specific, meaning they may have different attributes and
references compared to other ledgers.  Please visit [the Reference](/reference) to learn about resource
attributes.</div>

```ruby
resource = LedgerSync::Ledgers::QuickBooksOnline::Customer.new(
  DisplayName: 'Sample Customer',
  external_id: customer_external_id # A unique ID from your platform
)
```

## 3. Create an operation

Given our `client` and `resource` from above, we can now create an `Operation`.  Operations are typically CRUD-like
methods, typically (though not always) only making a single request.

Operations automatically determine a `Serializer` and `Deserializer`.  These serializers are used to translate to and
the from the ruby `Resource` in the format required by the ledger.

```ruby
operation = LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create.new(
  client: client,
  resource: resource
)
```

## 4. Perform the operation

The next step is to perform the operation.  You can do this by simply calling `perform`.

```ruby
result = operation.perform # Returns a LedgerSync::OperationResult
```

This method will return a
`LedgerSync::OperationResult` which is a special object allowing you to determine the success of the operation, access
responses values (serialized and deserialized), and investigate failures.

```ruby
if result.success?
  resource = result.operation.resource
  # Do something with resource
else # result.failure?
  raise result.error
end
```

## 5. Save updates to authentication

Because QuickBooks Online uses Oauth 2, you must always be sure to save the access_token, refresh_token, and expirations
as they can change with any API call.  Operations will always save values back to the client.

### Automatically update values in .env

If you have a `.env` file present in the root directory of your project, the client will automatically comment out old values and update new
values.

If you want to disable this functionality, you can do so by setting `update_dotenv` to `false` when instantiating the
object:

```ruby
client = LedgerSync::Ledgers::QuickBooksOnline::Client.new(
  access_token: access_token, # assuming this is defined
  client_id: ENV['QUICKBOOKS_ONLINE_CLIENT_ID'],
  client_secret: ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'],
  realm_id: ENV['QUICKBOOKS_ONLINE_REALM_ID'],
  refresh_token: refresh_token, # assuming this is defined
  update_dotenv: false
)
```

### Manually save values

```ruby
result.operation.client.ledger_attributes_to_save.each do |key, value|
  # save values
end
```

## Summary

That's it!  Assuming proper authentication values and valid values on the resource, this will result in a new customer
being created in QuickBooks Online.

There are many other resources and operations that can be performed in QuickBooks Online.  For a complete guide of these
and other ledgers, visit [the Reference](/reference).
