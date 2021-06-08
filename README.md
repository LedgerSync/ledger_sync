<a name="ledgersync" />

# LedgerSync

[![Build Status](https://travis-ci.org/LedgerSync/ledger_sync.svg?branch=master)](https://travis-ci.org/LedgerSync/ledger_sync)
[![Gem Version](https://badge.fury.io/rb/ledger_sync.svg)](https://badge.fury.io/rb/ledger_sync)
[![Coverage Status](https://coveralls.io/repos/github/LedgerSync/ledger_sync/badge.svg?branch=master)](https://coveralls.io/github/LedgerSync/ledger_sync?branch=master)

<a name="joinTheConversation" />

## Join the Conversation

[Click here](https://join.slack.com/t/ledger-sync/shared_invite/zt-e5nbl8qc-eOA~5k7bg3p16_l3J7OS~Q) to join our public Slack group.

**Table of Content**
- [LedgerSync](#ledgersync)	- [Join the Conversation](#joinTheConversation)	- [Documentation](#documentation)	- [License](#license)	- [Maintainers](#maintainers)- [Getting Started](#gettingStarted)	- [Installation](#installation)		- [Gemfile](#gemfile)		- [Directly](#directly)	- [Quick Start](#quickStart)		- [Overview](#overview01)			- [Manually save values](#manuallySaveValues)		- [Summary](#summary)	- [Get Help](#getHelp)	- [Report a bug](#reportABug)- [Architecture](#architecture)	- [Clients](#clients)		- [Overview](#overview01)		- [How to use](#howToUse01)		- [Gotchas](#gotchas)	- [Resources](#resources)		- [Overview](#overview02)		- [How to use](#howToUse01)		- [Available resources](#availableResources)		- [Resource Attributes](#resourceAttributes)	- [Serialization](#serialization)		- [Overview](#overview03)		- [Serializers](#serializers01)		- [Serializers](#serializers01)		- [How to use](#howToUse02)	- [Operations](#operations)		- [Contracts](#contracts)- [A valid case](#aValidCase)- [An invalid case](#anInvalidCase)	- [Searchers](#searchers)


<a name="documentation" />

## Documentation

The most up-to-date documentation can be found at [www.ledgersync.dev](http://www.ledgersync.dev)

<a name="license" />

## License

The gem is available as open source under the terms of the licenses detailed in `LICENSE.txt`.

<a name="maintainers" />

## Maintainers

A big thank you to our maintainers:

- [@ryanwjackson](https://github.com/ryanwjackson)
- [@jozefvaclavik](https://github.com/jozefvaclavik)
- [@SeanBolt](https://github.com/SeanBolt)
- And the whole [Modern Treasury](https://www.moderntreasury.com) team

<a name="gettingStarted" />

# Getting Started


<a name="installation" />

## Installation
<a name="gemfile" />

### Gemfile
Add this line to your application’s Gemfile:
```
gem 'ledger_sync'
```

And then execute:
```
bundle
```

<a name="directly" />

### Directly
Or install it yourself as:
```
gem install ledger_sync
```

<a name="quickStart" />

## Quick Start

<a name="overview" />

### Overview

To use LedgerSync, you must carry out an **Operation**. The **operation** will be ledger-specific and will require the
following:

1. Client
2. Resource(s)

### 1. Create a Client

Clients are responsible for the authentication and requests for a specific ledger. In this example, we will assume you
are using the QuickBooks Online ledger.

> Note: Each ledger has different requirements for authentication. Please visit the ledger-specific pages to learn more.

```ruby
client = LedgerSync::Ledgers::QuickBooksOnline::Client.new(
  access_token: access_token, # assuming this is defined
  client_id: ENV['QUICKBOOKS_ONLINE_CLIENT_ID'],
  client_secret: ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'],
  realm_id: ENV['QUICKBOOKS_ONLINE_REALM_ID'],
  refresh_token: refresh_token # assuming this is defined
)
```

### 2. Create resources(s)

Create a resource on which to operate. Some resources have references to other resources. You can
use `Util::ResourcesBuilder` to create resources and relationships from a structured hash.

> Note: Resources are ledger-specific, meaning they may have different attributes and references compared to other ledgers. Please visit [the Reference](/reference) to learn about resource attributes.

```ruby
resource = LedgerSync::Ledgers::QuickBooksOnline::Customer.new(
  DisplayName: 'Sample Customer',
  external_id: customer_external_id # A unique ID from your platform
)
```

### 3. Create an operation

Given our `client` and `resource` from above, we can now create an `Operation`. Operations are typically CRUD-like
methods, typically (though not always) only making a single request.

Operations automatically determine a `Serializer` and `Deserializer`. These serializers are used to translate to and the
from the ruby `Resource` in the format required by the ledger.

```ruby
operation = LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create.new(
  client: client,
  resource: resource
)
```

### 4. Perform the operation

The next step is to perform the operation. You can do this by simply calling `perform`.

```ruby
result = operation.perform # Returns a LedgerSync::OperationResult
```

### 5. Save updates to authentication

Because QuickBooks Online uses Oauth 2, you must always be sure to save the access_token, refresh_token, and expirations
as they can change with any API call. Operations will always save values back to the client.

#### Automatically update values in .env

If you have a `.env` file present in the root directory of your project, the client will automatically comment out old
values and update new values.

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

<a name="manuallySaveValues" />

#### Manually save values
```ruby
result.operation.client.ledger_attributes_to_save.each do |key, value|
  # save values
end
```

<a name="summary" />

### Summary
That’s it! Assuming proper authentication values and valid values on the resource, this will result in a new customer being created in QuickBooks Online.

There are many other resources and operations that can be performed in QuickBooks Online. For a complete guide of these and other ledgers, visit the Reference.

<a name="getHelp" />

## Get Help

There is a group of passionate maintainers happy to help you get started with LedgerSync. There are two main channels
for discussing LedgerSync: [Github](https://github.com/LedgerSync/ledger_sync) and [Slack](https://join.slack.com/t/ledger-sync/shared_invite/zt-e5nbl8qc-eOA~5k7bg3p16_l3J7OS~Q).

<a name="reportABug" />

## Report a bug
Please [open an issue on Github](https://www.github.com/LedgerSync/ledger_sync/issues/new) to report any bugs. Please check if the bug has previously been reported and comment on the open issue with your use case.

<a name="architecture" />

# Architecture

LedgerSync consists of the following high-level objects:
- [Clients](#clients)
- [Resources](#resources)
- [Serialization](#serialization)
- [Operations](#operations)
- [Searchers](#searchers)
- [Results]()

<a name="clients" />

## Clients

<a name="overview01" />

### Overview

Clients handle the authentication and requests to the ledger. A ledger may have different authentication strategies, so
clients will accept different arguments. For example, QuickBooks Online utilizes Oauth 2.0 while NetSuite offers Token
Based Authentication. While similar, the required keys are different.

<a name="howToUse" />

### How to use

Unless you are customizing LedgerSync, you will always pass an instantiated client to an object (e.g. an operation). The
object will handle using the client as needed.

As most clients implement basic request functionality (e.g. `get`, `put`, `post`, `delete`, etc.), you can call these
methods directly to perform custom requests. Refer to the specific Client definitions for what parameters are permitted.

<a name="gotchas" />

### Gotchas

#### Oauth 2.0

Clients store the authentication details for the ledger. Given that Oauth 2.0 tokens can refresh during a request, these
clients will handle saving credentials back to the client instance. Typically (though some clients offer more automated
solutions), you will want to save any changes back to your database. You can use `client.ledger_attributes_to_save` to
retrieve a hash of which attributes to save. Your code to do so could look like the following:

```ruby
1
2
3
4
# Assuming `client` is defined as an instance of a ledger Client class
client.ledger_attributes_to_save.each do |attribute_to_save, value|
  # Store value
end

```

<a name="resources" />

## Resources

<a name="overview02" />

### Overview

Resources are named ruby objects (e.g. `Customer`, `Payment`, etc.) with strict attributes (e.g. `name`, `amount`, etc.)
. LedgerSync provides resources specific to each ledger. While it is possible to create your own resources (see
Customization for more details), this section refers to provided ledger-specific resources.

The library strives to make each resource and attribute name match the ledger API. This naming convention will help you
more readily match ledger documentation to LedgerSync resources.

Every resource, regardless of ledger, implements a `ledger_id` and `external_id` attribute. The `ledger_id` is the ID
given by the ledger, while the `external_id` is your internal ID for the resource.

<a name="howToUse01" />

### How to use

Resources are primary used as the inputs and outputs of operations and searchers. A resource is passed to an operation
along with a client. Once the operation is successfully performed, a duplicated and updated resource is returned.

Resources have two layers of validation:

1. The Resource
2. Operations

When instantiating a resource, validations are performed. These validations include class checks and, if necessary,
value checks (e.g. enums). When performing an operation, validations are performed based on what attributes are required
for the operation to be successful. For example, the `ledger_id` should be `nil` on `create`, but it should be present
on
`update`.

<a name="availableResources" />

### Available resources

You can see all resources available for a given ledger by calling `resources` on the ledger’s Client like so:

`LedgerSync::Ledgers::QuickBooksOnline::Client.resources`

This returns a hash of resource types to classes, where the resource types are unique (e.g. `customer`, `vendor`, etc.).

You can see all resources available in LedgerSync by calling `LedgerSync.resources`. This returns an array (note: not a
hash as multiple ledgers have the same types) of resource classes that have been created inheriting the `LedgerSync::
Resource` class.

<a name="resourceAttributes" />

### Resource Attributes

Resources have defined attributes. Attributes are explicitly defined. An error is thrown if an unknown attribute is
passed to it. You can retrieve the attributes of a resource by calling `Customer.attributes`.

A subset of these `attributes` may be a `reference`, which is simply a special type of attribute that references another
resource. You can retrieve the references of a resource by calling `Customer.references`.

<a name="serialization" />

## Serialization

<a name="overview03" />

### Overview

LedgerSync leverages serialization and deserialization to convert resources into the necessary hash formats the ledger
expects. Generally, each resource will have 1 serializer and 1 deserializer.

<a name="serializers" />

### Serializers

Serializers take a `Resource` and output a hash. For example:

```ruby
customer = LedgerSync::Ledgers::NetSuite::Customer.new(
  companyName: 'Test Company',
  external_id: 'ext_123'
)
serializer = LedgerSync::Ledgers::NetSuite::Customer::Serializer.new
serializer.serialize(resource: customer)
# Sample output:
# {
#   "companyName" => "Test Company",
#   "externalId" => "ext_123",
#   "email" => nil,
#   "phone" => nil,
#   "firstName" => nil,
#   "lastName" => nil,
#   "subsidiary" => nil
# }
end

```

<a name="serializers01" />

### Serializers

Deserializers take a hash and output a `Resource`. For example:

```ruby
h = {
  "companyName" => "Test Company",
  "externalId" => "ext_123",
  "email" => nil,
  "id" => "987654321",
  "phone" => nil,
  "firstName" => nil,
  "lastName" => nil,
  "subsidiary" => nil
}

deserializer = LedgerSync::Ledgers::NetSuite::Customer::Deserializer.new
customer = deserializer.deserialize(hash: h, resource: LedgerSync::Ledgers::NetSuite::Customer.new)
customer.ledger_id # => "987654321"
customer.companyName # => "Test Company"

```

<a name="howToUse02" />

### How to use

Serializers and deserializers are automatically inferred by each operation based on the naming convention. It is
possible to create your own serializers. Please see Customization for more.

<a name="operations" />

## Operations

Each ledger defines operations that can be performed on specific resources (e.g. `Customer::Operations::Update`
, `Payment::
Operations::Create`). The operation defines two key things:

- a `Contract` class which is used to validate the resource using the `dry-validation` gem
- a `perform` instance method, which handles the actual API requests and response/error handling.

> Note: Ledgers may support different operations for each resource type.

<a name="contracts" />

### Contracts

Contracts are dry-validation schemas, which determine if an operation can be performed. You can create custom schemas
and pass them to operations. Assuming you have an `operation_class` variable and `foo` is an attribute of a
`custom_resource` (see above) that is required to be a string, you can implement it with the following:


```ruby
class CustomContract < LedgerSync::Ledgers::Contract
  params do
    required(:foo).filled(:string)
  end
end

<a name="aValidCase" />

# A valid case
custom_resource = CustomResource.new(foo: 'asdf')
op = operation_class.new(
  client: client,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => true

<a name="anInvalidCase" />

# An invalid case
custom_resource = CustomResource.new(foo: nil)
operation_class.new(
  client: client,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => false


```

<a name="searchers" />

## Searchers

Searchers are used to lookup and scan objects in the ledger. A searcher takes a `client`, _query_ string and optional `pagination` hash. For example, to search customer’s by name:

```ruby
searcher = LedgerSync::Ledgers::QuickBooksOnline::Customer::Searcher.new(
  client: client # assuming this is defined,
  query: 'test'
)

result = searcher.search # returns a LedgerSync::SearchResult

if result.success?
  resources = result.resources
  # Do something with found resources
else # result.failure?
  raise result.error
end

# Different ledgers may use different pagination strategies.  In order
# to get the next and previous set of results, you can use the following:
next_searcher = searcher.next_searcher
previous_searcher = searcher.previous_searcher

```