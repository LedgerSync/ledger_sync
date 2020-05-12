# LedgerSync

[![Build Status](https://travis-ci.org/LedgerSync/ledger_sync.svg?branch=master)](https://travis-ci.org/LedgerSync/ledger_sync)
[![Gem Version](https://badge.fury.io/rb/ledger_sync.svg)](https://badge.fury.io/rb/ledger_sync)
[![Coverage Status](https://coveralls.io/repos/github/LedgerSync/ledger_sync/badge.svg?branch=master)](https://coveralls.io/github/LedgerSync/ledger_sync?branch=master)

## Join the Conversation

[Click here](https://join.slack.com/t/ledger-sync/shared_invite/zt-e5nbl8qc-eOA~5k7bg3p16_l3J7OS~Q) to join our public Slack group.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ledger_sync'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install ledger_sync
```

## Usage

To use LedgerSync, you must create an `Operation`.  The operation will be ledger-specific and will require the following:

1. Ledger
2. Resource(s)

The code may look like the following:

```ruby
# First we create an client, which is our client to a ledger.
# Each ledger may require different keys, so check the
# documentation below for specifics.
client = LedgerSync::Ledgers::QuickBooksOnline::Client.new(
  access_token: access_token, # assuming this is defined
  client_id: ENV['QUICKBOOKS_ONLINE_CLIENT_ID'],
  client_secret: ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'],
  realm_id: ENV['QUICKBOOKS_ONLINE_REALM_ID'],
  refresh_token: refresh_token, # assuming this is defined
)

# Create a resource on which to operate.  Some resources have
# relationships with other resources.  You can use
# `Util::ResourcesBuilder` to create resources and relationships from
# a structured hash.
resource = LedgerSync::Customer.new(
  name: 'Sample Customer',
  email: 'test@example.com'
)

# Create the operation we want to perform.
operation = LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create.new(
  client: client,
  resource: resource
)

result = operation.perform # Returns a LedgerSync::OperationResult

if result.success?
  resource = result.operation.resource
  # Do something with resource
else # result.failure?
  raise result.error
end

# Because QuickBooks Online uses Oauth 2, you must always be sure to
# save the access_token, refresh_token, and expirations as they can
# change with any API call.
result.operation.client.ledger_attributes_to_save.each do |key, value|
  # save values
end
```

## How it Works

This library consists of two important layers:

1. Resources
2. Ledgers

### Resources

Resources are named ruby objects (e.g. `Customer`, `Payment`, etc.) with strict attributes (e.g. `name`, `amount`, etc.).  They are a layer between your application and an client.  They can be validated using an client.  You can create and use the resources, and an client will update resources as needed based on the intention and outcome of that operation.

You can find supported resources by calling `LedgerSync.resources`.

Resources have defined attributes.  Attributes are explicitly defined.  An error is thrown if an unknown attribute is passed to it.  You can retrieve the attributes of a resource by calling `LedgerSync::Customer.attributes`.

A subset of these `attributes` may be a `reference`, which is simply a special type of attribute that references another resource.  You can retrieve the references of a resource by calling `LedgerSync::Customer.references`.

#### Custom Attributes

Some ledgers (e.g. NetSuite) allow for custom attributes (or "fields"), which can vary by account and user.  To allow for custom attributes, you can create new resources, ledger serializers (see below), and validation contracts (see below).  Assuming your ledger supports the string attribute `foo` for customers, you could do the following:

```ruby
class CustomCustomer < LedgerSync::Customer
  attribute :foo, type: LedgerSync::Type::String
end
```

Depending on your use of LedgerSync, you may need to define resources dynamically with different custom attributes.  You could do so using something like the following:

```ruby
custom_attributes_for_customers = [
  [
    [:foo, LedgerSync::Type::String]
  ],
  [
    [:foo, LedgerSync::Type::Integer],
    [:bar, LedgerSync::Type::Boolean]
  ]
]

custom_customer_classes = custom_attributes_for_customers.map do |attributes|
  customer_class = Class.new(LedgerSync::Customer)
  attributes.each do |name, type|
    customer_class.attribute name, type: type
  end
  customer_class
end

customer_class_1, customer_class_2 = custom_customer_classes

# First Custom Customer Class
customer_class_1.resource_attributes.include?(:foo) # => true
customer_class_1.resource_attributes[:foo].type # => #<LedgerSync::Type::String:0x00007fe04e9529b0 @precision=nil, @scale=nil, @limit=nil>
customer_class_1.resource_attributes.include?(:bar) # => false

# Second Custom Customer Class
customer_class_2.resource_attributes.include?(:foo) # => true
customer_class_2.resource_attributes[:foo].type # => #<LedgerSync::Type::Integer:0x00007fe04e2c7898 @precision=nil, @scale=nil, @limit=nil, @range=-2147483648...2147483648>
customer_class_2.resource_attributes.include?(:bar) # => true
customer_class_2.resource_attributes[:bar].type # => #<LedgerSync::Type::Boolean:0x00007fe04e2e4f10 @precision=nil, @scale=nil, @limit=nil>
```

You can now use these custom resources in operations that require custom attributes.

### Ledgers

Ledgers are ledger-specific ruby objects that contain all the logic to authenticate to a ledger, perform ledger-specific operations, and validate resources based on the requirements of the ledger.  Ledgers contain a number of useful objects:

- connectn
- serializers
- operations
- searchers

#### Ledger

The client handles authentication and requests to the ledger.  Each clients initializer will vary based on the needs of that ledger.

#### Serializers

Operations depend on `LedgerSync::Ledger::LedgerSerializer`s to serialize and deserialize objects.  Most resources have a default serializer per client which may acts as both a serializer and deserializer.  You can provide custom serializers, which is necessary when working with custom attributes.  For example, given the following:
- `custom_resource` that is a `LedgerSync::Customer` (see above)
- the attribute `foo` is used in both the request and response bodies
- using the `NetSuite` client

you could implement custom serializers using the following code:

```ruby
class CustomSerializer < LedgerSync::Ledgers::NetSuite::Customer::LedgerSerializer
  attribute ledger_attribute: :foo,
            resource_attribute: :foo,
            deserialize: true, # optional, default: true
            serialize: true # optional, default: true
end

# Serializing
custom_resource = CustomCustomer.new(foo: 'asdf') # See above under Resources -> Custom Attributes
serializer = CustomSerializer.new(resource: custom_resource)
serializer.to_ledger_hash # => {"foo"=>"asdf"}

# Deserializing
deserialized_resource = serializer.deserialize(hash: { foo: 'qwerty' })
deserialized_resource.foo # => 'qwerty'
custom_resource.foo # => 'asdf'

op = LedgerSync::Ledgers::NetSuite::Customer::Operations::Create.new(
  client: client,
  ledger_deserializer_class: CustomSerializer, # You must specify, though you could use a separate class
  ledger_serializer_class: CustomSerializer,
  resource: custom_resource
)
```

Note that in the above example, we extend an existing customer serializer in the NetSuite client.  In most cases, serializers have the following inheritance pattern: `LedgerSync::Ledgers::[ADAPTOR]::[RESOURCE]::LedgerSerializer <  LedgerSync::Ledgers::[ADAPTOR]::LedgerSerializer <  LedgerSync::Ledgers::LedgerSerializer`

So in this example, it would be `LedgerSync::Ledgers::NetSuite::Customer::LedgerSerializer <  LedgerSync::Ledgers::NetSuite::LedgerSerializer <  LedgerSync::Ledgers::LedgerSerializer`.  The more specific the serializer, the more helper methods are available that are client and/or resource specific.

#### Operation

Each client defines operations that can be performed on specific resources (e.g. `Customer::Operations::Update`, `Payment::Operations::Create`).  The operation defines two key things:

- a `Contract` class which is used to validate the resource using the `dry-validation` gem
- a `perform` instance method, which handles the actual API requests and response/error handling.

Note: Ledgers may support different operations for each resource type.

##### Contracts

Contracts are dry-validation schemas, which determine if an operation can be performed.  You can create custom schemas and pass them to operations.  Assuming you have an `operation_class` variable and `foo` is an attribute of a `custom_resource` (see above) that is required to be a string, you can implement it with the following:

```ruby
class CustomContract < LedgerSync::Ledgers::Contract
  params do
    required(:foo).filled(:string)
  end
end

# A valid case
custom_resource = CustomResource.new(foo: 'asdf')
op = operation_class.new(
  client: client,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => true

# An invalid case
custom_resource = CustomResource.new(foo: nil)
operation_class.new(
  client: client,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => false

```

#### Searcher

Searchers are used to search objects in the ledger.  A searcher takes an `client`, `query` string and optional `pagination` hash.  For example, to search customer's by name:

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

## NetSuite

The NetSuite client leverages NetSuite's REST API.

### Resource Metadata and Schemas

Due to NetSuites granular user permissions and custom attributes, resources and methods for those resources can vary from one user (a.k.a. token) to another.  Because of this variance, there are some helper classes that allow you to retrieve NetSuite records, allowed methods, attributes/parameters, etc.

To retrieve the metadata for a record:

```ruby
metadata = LedgerSync::Ledgers::NetSuite::Record::Metadata.new(
  client: netsuite_client, # Assuming this is previous defined
  record: :customer
)

puts metadata.http_methods # Returns a list of LedgerSync::Ledgers::NetSuite::Record::HTTPMethod objects
puts metadata.properties # Returns a list of LedgerSync::Ledgers::NetSuite::Record::Property objects
```

### Reference

- [NetSuite REST API Documentation](https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSTRW/NSTRW.pdf)

## NetSuite SOAP

LedgerSync supports the NetSuite SOAP client, leveraging [the NetSuite gem](https://github.com/NetSweet/netsuite).  The client and sample operations are provided, though the main NetSuite client uses the REST API.

### Reference

- [NetSuite SOAP API Documentation](https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSTWR/NSTWR.pdf)


## QuickBooks Online

### OAuth

QuickBooks Online utilizes OAuth 2.0, which requires frequent refreshing of the access token.  The client will handle this automatically, attempting a single token refresh on any single request authentication failure.  Depending on how you use the library, every client has implements a class method `ledger_attributes_to_save`, which is an array of attributes that may change as the client is used.  You can also call the instance method `ledger_attributes_to_save` which will be a hash of these values.  It is a good practice to always store these attributes if you are saving access tokens in your database.

#### Retrieve Access Token

The library contains a lightweight script that is helpful in retrieving and refreshing access tokens.  To use, do the following:

1. Create a `.env` file in the library root.
2. Add values for `QUICKBOOKS_ONLINE_CLIENT_ID` and `QUICKBOOKS_ONLINE_CLIENT_SECRET` (you can copy `.env.template`).
3. Ensure your developer application in [the QuickBooks Online developer portal](https://developer.intuit.com) contains this redirect URI: `http://localhost:5678` (note: no trailing slash and port configurable with `PORT` environment variable)
4. Run `ruby bin/quickbooks_online_oauth_server.rb` from the library root (note: it must run from the root in order to update `.env`).
5. Visit the URL output in the terminal.
6. Upon redirect back to your `localhost`, the new values will be printed to the console and saved back to your `.env`

#### Ledger Helper Methods

The client also implements some helper methods for getting tokens.  For example, you can set up an client using the following:

```ruby
# Retrieve the following values from Intuit app settings
client_id     = 'ID'
client_secret = 'SECRET'
redirect_uri  = 'http://localhost:3000'

oauth_client = LedgerSync::Ledgers::QuickBooksOnline::OAuthClientHelper.new(
  client_id: client_id,
  client_secret: client_secret
)

puts oauth_client.authorization_url(redirect_uri: redirect_uri)

# Visit on the output URL and authorize a company.
# You will be redirected back to the redirect_uri.
# Copy the full url from your browser:

uri = 'https://localhost:3000/?code=FOO&state=BAR&realm_id=BAZ'

client = LedgerSync::Ledgers::QuickBooksOnline::Client.new_from_oauth_client_uri(
  oauth_client: oauth_client,
  uri: uri
)

# You can test that the auth works:

client.refresh!
```

**Note: If you have a `.env` file storing your secrets, the client will automatically update the variables and record previous values whenever values change**

### Webhooks

Reference: [QuickBooks Online Webhook Documentation](https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification)

LedgerSync offers an easy way to validate and parse webhook payloads.  It also allows you to easily fetch the resources referenced.  You can create and use a webhook with the following:

```ruby
# Assuming `request` is the webhook request received from Quickbooks Online
webhook = LedgerSync::Ledgers::QuickBooksOnline::Webhook.new(
  payload: request.body.read # It accepts a JSON string or hash
)

verification_token = WEBHOOK_VERIFICATION_TOKEN # You get this token when you create webhooks in the QuickBooks Online dashboard
signature = request.headers['intuit-signature']
raise 'Not valid' unless webhook.valid?(signature: signature, verification_token: verification_token)

# Although not yet used, webhooks may include notifications for multiple realms
webhook.notifications.each do |notification|
  puts notification.realm_id

  # Multiple events may be referenced.
  notification.events.each do |event|
    puts event.resource # Returns a LedgerSync resource with the `ledger_id` set

    # Other helpful methods
    notification.find_operation_class(client: your_quickbooks_client_instance) # The respective Find class
    notification.find_operation(client: your_quickbooks_client_instance) # The initialized respective Find operation
    notification.find(client: your_quickbooks_client_instance) # Performs a Find operation for the resource retrieving the latest version from QuickBooks Online
  end

  # Other helpful methods
  notification.resources # All resources for a given webhook across all events
end

# Other helpful methods
webhook.events # All events for a given webhook across all realms
webhook.resources # All events for a given webhook across all realms and events
```

### Errors

- [QuickBooks Online Error Documentation](https://developer.intuit.com/app/developer/qbo/docs/develop/troubleshooting/error-codes)

## Tips and More

### Keyword Arguments

LedgerSync heavily uses ruby keyword arguments so as to make it clear what values are being passed and which attributes are required.  When this README says something like "the `fun_function` function takes the argument `foo`" that translates to `fun_function(foo: :some_value)`.

### Fingerprints

Most objects in LedgerSync can be fingerprinted by calling the instance method `fingerprint`.  For example:

```ruby
puts LedgerSync::Customer.new.fingerprint # "b3eab7ec00431a4ae0468fee72e5ba8f"

puts LedgerSync::Customer.new.fingerprint == LedgerSync::Customer.new.fingerprint # true
puts LedgerSync::Customer.new.fingerprint == LedgerSync::Customer.new(name: :foo).fingerprint # false
puts LedgerSync::Customer.new.fingerprint == LedgerSync::Payment.new.fingerprint # false
```

Fingerprints are used to compare objects.  This method is used in de-duping objects, as it only considers the data inside and not the instance itself (as shown above).

### Serialization

Most objects in LedgerSync can be serialized by calling the instance method `serialize`.  For example:

```ruby
puts LedgerSync::Payment.new(
  customer: LedgerSync::Customer.new
)

{
  root: "LedgerSync::Payment/8eed81c0177801a001f2544f0c85e21d",
  objects: {
    "LedgerSync::Payment/8eed81c0177801a001f2544f0c85e21d": {
      id: "LedgerSync::Payment/8eed81c0177801a001f2544f0c85e21d",
      object: "LedgerSync::Payment",
      fingeprint: "8eed81c0177801a001f2544f0c85e21d",
      data: {
        currency: nil,
        amount: nil,
        customer: {
          object: "reference",
          id: "LedgerSync::Customer/b3eab7ec00431a4ae0468fee72e5ba8f"
        },
        external_id: "",
        ledger_id: nil,

      }
    },
    "LedgerSync::Customer/b3eab7ec00431a4ae0468fee72e5ba8f": {
      id: "LedgerSync::Customer/b3eab7ec00431a4ae0468fee72e5ba8f",
      object: "LedgerSync::Customer",
      fingeprint: "b3eab7ec00431a4ae0468fee72e5ba8f",
      data: {
        name: nil,
        email: nil,
        phone_number: nil,
        external_id: "",
        ledger_id: nil
      }
    }
  }
}
```

The serialization of any object follows the same structure.  There is a `:root` key that holds the ID of the root object.  There is also an `:objects` hash that contains all of the objects for this serialization.  As you can see, unique nested objects listed in the `:objects` hash and referenced using a "reference object", in this case:

```ruby
{
  object: "reference",
  id: "LedgerSync::Customer/b3eab7ec00431a4ae0468fee72e5ba8f"
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org)

### Testing

Run `bundle exec rspec` to run all unit, feature, and integration tests.  Unlike QA Tests, all external HTTP requests and responses are stubbed.

### QA Testing

**BE SURE TO USE A TEST ENVIRONMENT ON YOUR LEDGER.**

To fully test the library against the actual ledgers, you can run `bin/qa` which will run all tests in the `qa/` directory.  QA Tests are written in RSpec.  Unlike tests in the `spec/` directory, QA tests allow external HTTP requests.

As these interact with real ledgers, you will need to provide secrets.  You can do so in a `.env` file in the root directory.  Copy the `.env.template` file to get started.

**WARNINGS:**

- **BE SURE TO USE A TEST ENVIRONMENT ON YOUR LEDGER.**
- **NEVER CHECK IN YOUR SECRETS (e.g. the `.env` file).**
- Because these tests actually create and modify resources, they attempt to do "cleanup" by deleting any newly created resources.  This process could fail, and you may need to delete these resources manually.

### Console

Run `bundle console` to start and interactive console with the library already loaded. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Deployment

To deploy a new version of the gem to RubyGems, you can use the `release.sh` script in the root.  The script takes advantage of [the bump gem](https://github.com/gregorym/bump).  So you may call the script using any of the following:

```bash
# Version Format: MAJOR.MINOR.PATCH
./release.sh patch # to bump X in 1.1.X
./release.sh minor # to bump X in 1.X.1
./release.sh major # to bump X in X.1.1
```

### Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LedgerSync/ledger_sync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

### Code of Conduct

Everyone interacting in the LedgerSync project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/LedgerSync/ledger_sync/blob/master/CODE_OF_CONDUCT.md).

# Maintainers

A big thank you to our maintainers:

- [@ryanwjackson](https://github.com/ryanwjackson)
- [@jozefvaclavik](https://github.com/jozefvaclavik)
- And the whole [Modern Treasury](https://www.moderntreasury.com) team
