# LedgerSync

[![Build Status](https://travis-ci.org/LedgerSync/ledger_sync.svg?branch=master)](https://travis-ci.org/LedgerSync/ledger_sync)
[![Gem Version](https://badge.fury.io/rb/ledger_sync.svg)](https://badge.fury.io/rb/ledger_sync)
[![Coverage Status](https://coveralls.io/repos/github/LedgerSync/ledger_sync/badge.svg?branch=master)](https://coveralls.io/github/LedgerSync/ledger_sync?branch=master)

## Join the Conversation

[Click here](https://join.slack.com/t/ledger-sync/shared_invite/zt-cn4qfhb8-~6BrVy8v7~upxQk6Pfo7oQ) to join our public Slack group.

<svg xmlns="http://www.w3.org/2000/svg" shape-rendering="geometricPrecision" viewBox="0 0 240 60" width="100" height="25" aria-label="Slack" class="c-slacklogo--color svg-replaced"><path d="m75.663 47.477 2.929-6.846c3.207 2.375 7.39 3.632 11.574 3.632 3.068 0 5.02-1.187 5.02-3.003-.07-5.03-18.477-1.118-18.617-13.764-.07-6.427 5.648-11.387 13.737-11.387 4.81 0 9.622 1.188 13.038 3.913l-2.737 6.992c-3.143-2.021-7.025-3.43-10.72-3.43-2.51 0-4.184 1.187-4.184 2.725.07 4.96 18.618 2.235 18.827 14.322 0 6.567-5.579 11.178-13.528 11.178-5.856 0-11.225-1.397-15.34-4.332m116.629-9.325a8.498 8.498 0 0 1 -7.405 4.33c-4.698 0-8.506-3.816-8.506-8.523s3.808-8.523 8.506-8.523a8.498 8.498 0 0 1 7.405 4.33l8.143-4.52c-3.05-5.451-8.868-9.137-15.548-9.137-9.839 0-17.815 7.991-17.815 17.85 0 9.858 7.976 17.85 17.815 17.85 6.68 0 12.498-3.686 15.548-9.137zm-82.477 12.958h10.18v-49.86h-10.179zm95.761-49.86v49.86h10.18v-14.938l12.063 14.938h13.012l-15.34-17.746 14.224-16.559h-12.454l-11.505 13.767v-29.322zm-54.218 15.557v4.053c-1.673-2.795-5.787-4.751-10.11-4.751-8.925 0-15.967 7.895-15.967 17.815s7.042 17.885 15.967 17.885c4.323 0 8.437-1.956 10.11-4.751v4.052h10.18v-34.303zm0 21.414c-1.464 2.445-4.532 4.26-7.948 4.26-4.699 0-8.507-3.815-8.507-8.522s3.808-8.523 8.507-8.523c3.416 0 6.484 1.886 7.948 4.4z"></path><path d="m21.902.148c-3.299 0-5.973 2.68-5.973 5.985a5.979 5.979 0 0 0 5.973 5.985h5.974v-5.985a5.98 5.98 0 0 0 -5.974-5.985m0 15.96h-15.929c-3.299 0-5.973 2.68-5.973 5.986 0 3.305 2.674 5.985 5.973 5.985h15.93c3.298 0 5.973-2.68 5.973-5.985 0-3.306-2.675-5.986-5.974-5.986" fill="#36c5f0"></path><path d="m59.734 22.094c0-3.306-2.675-5.986-5.974-5.986s-5.973 2.68-5.973 5.986v5.985h5.973a5.98 5.98 0 0 0 5.974-5.985m-15.929 0v-15.961a5.98 5.98 0 0 0 -5.974-5.985c-3.299 0-5.973 2.68-5.973 5.985v15.96c0 3.307 2.674 5.987 5.973 5.987a5.98 5.98 0 0 0 5.974-5.985" fill="#2eb67d"></path><path d="m37.831 60a5.98 5.98 0 0 0 5.974-5.985 5.98 5.98 0 0 0 -5.974-5.985h-5.973v5.985c0 3.305 2.674 5.985 5.973 5.985m0-15.96h15.93c3.298 0 5.973-2.68 5.973-5.986a5.98 5.98 0 0 0 -5.974-5.985h-15.929c-3.299 0-5.973 2.68-5.973 5.985a5.979 5.979 0 0 0 5.973 5.985" fill="#ecb22e"></path><path d="m0 38.054a5.979 5.979 0 0 0 5.973 5.985 5.98 5.98 0 0 0 5.974-5.985v-5.985h-5.974c-3.299 0-5.973 2.68-5.973 5.985m15.929 0v15.96c0 3.306 2.674 5.986 5.973 5.986a5.98 5.98 0 0 0 5.974-5.985v-15.961a5.979 5.979 0 0 0 -5.974-5.985c-3.299 0-5.973 2.68-5.973 5.985" fill="#e01e5a"></path></svg>

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

1. Adaptor
2. Resource(s)

The code may look like the following:

```ruby
# First we create an adaptor, which is our connection to a ledger.
# Each ledger may require different keys, so check the
# documentation below for specifics.
adaptor = LedgerSync::Adaptors::QuickBooksOnline::Adaptor.new(
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
operation = LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create.new(
  adaptor: adaptor,
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
result.operation.adaptor.ledger_attributes_to_save.each do |key, value|
  # save values
end
```

## How it Works

This library consists of two important layers:

1. Resources
2. Adaptors

### Resources

Resources are named ruby objects (e.g. `Customer`, `Payment`, etc.) with strict attributes (e.g. `name`, `amount`, etc.).  They are a layer between your application and an adaptor.  They can be validated using an adaptor.  You can create and use the resources, and an adaptor will update resources as needed based on the intention and outcome of that operation.

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
  klass = Class.new(LedgerSync::Customer)
  attributes.each do |name, type|
    klass.attribute name, type: type
  end
  klass
end

klass1, klass2 = custom_customer_classes

# First Custom Customer Class
klass1.resource_attributes.include?(:foo) # => true
klass1.resource_attributes[:foo].type # => #<LedgerSync::Type::String:0x00007fe04e9529b0 @precision=nil, @scale=nil, @limit=nil>
klass1.resource_attributes.include?(:bar) # => false

# Second Custom Customer Class
klass2.resource_attributes.include?(:foo) # => true
klass2.resource_attributes[:foo].type # => #<LedgerSync::Type::Integer:0x00007fe04e2c7898 @precision=nil, @scale=nil, @limit=nil, @range=-2147483648...2147483648>
klass2.resource_attributes.include?(:bar) # => true
klass2.resource_attributes[:bar].type # => #<LedgerSync::Type::Boolean:0x00007fe04e2e4f10 @precision=nil, @scale=nil, @limit=nil>
```

You can now use these custom resources in operations that require custom attributes.

### Adaptors

Adaptors are ledger-specific ruby objects that contain all the logic to authenticate to a ledger, perform ledger-specific operations, and validate resources based on the requirements of the ledger.  Adaptors contain a number of useful objects:

- adaptor
- serializers
- operations
- searchers

#### Adaptor

The adaptor handles authentication and requests to the ledger.  Each adaptors initializer will vary based on the needs of that ledger.

#### Serializers

Operations depend on `LedgerSync::Adaptor::LedgerSerializer`s to serialize and deserialize objects.  Most resources have a default serializer per adaptor which may acts as both a serializer and deserializer.  You can provide custom serializers, which is necessary when working with custom attributes.  For example, given the following:
- `custom_resource` that is a `LedgerSync::Customer` (see above)
- the attribute `foo` is used in both the request and response bodies
- using the `NetSuite` adaptor

you could implement custom serializers using the following code:

```ruby
class CustomSerializer < LedgerSync::Adaptors::NetSuite::Customer::LedgerSerializer
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

op = LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
  adaptor: adaptor,
  ledger_deserializer_class: CustomSerializer, # You must specify, though you could use a separate class
  ledger_serializer_class: CustomSerializer,
  resource: custom_resource
)
```

Note that in the above example, we extend an existing customer serializer in the NetSuite adaptor.  In most cases, serializers have the following inheritance pattern: `LedgerSync::Adaptors::[ADAPTOR]::[RESOURCE]::LedgerSerializer <  LedgerSync::Adaptors::[ADAPTOR]::LedgerSerializer <  LedgerSync::Adaptors::LedgerSerializer`

So in this example, it would be `LedgerSync::Adaptors::NetSuite::Customer::LedgerSerializer <  LedgerSync::Adaptors::NetSuite::LedgerSerializer <  LedgerSync::Adaptors::LedgerSerializer`.  The more specific the serializer, the more helper methods are available that are adaptor and/or resource specific.

#### Operation

Each adaptor defines operations that can be performed on specific resources (e.g. `Customer::Operations::Update`, `Payment::Operations::Create`).  The operation defines two key things:

- a `Contract` class which is used to validate the resource using the `dry-validation` gem
- a `perform` instance method, which handles the actual API requests and response/error handling.

Note: Adaptors may support different operations for each resource type.

##### Contracts

Contracts are dry-validation schemas, which determine if an operation can be performed.  You can create custom schemas and pass them to operations.  Assuming you have an `operation_class` variable and `foo` is an attribute of a `custom_resource` (see above) that is required to be a string, you can implement it with the following:

```ruby
class CustomContract < LedgerSync::Adaptors::Contract
  params do
    required(:foo).filled(:string)
  end
end

# A valid case
custom_resource = CustomResource.new(foo: 'asdf')
op = operation_class.new(
  adaptor: adaptor,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => true

# An invalid case
custom_resource = CustomResource.new(foo: nil)
operation_class.new(
  adaptor: adaptor,
  resource: resource,
  validation_contract: CustomContract
)
op.valid? # => false

```

#### Searcher

Searchers are used to search objects in the ledger.  A searcher takes an `adaptor`, `query` string and optional `pagination` hash.  For example, to search customer's by name:

```ruby
searcher = LedgerSync::Adaptors::QuickBooksOnline::Customer::Searcher.new(
  adaptor: adaptor # assuming this is defined,
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

The NetSuite adaptor leverages NetSuite's REST API.

### Resource Metadata and Schemas

Due to NetSuites granular user permissions and custom attributes, resources and methods for those resources can vary from one user (a.k.a. token) to another.  Because of this variance, there are some helper classes that allow you to retrieve NetSuite records, allowed methods, attributes/parameters, etc.

To retrieve the metadata for a record:

```ruby
metadata = LedgerSync::Adaptors::NetSuite::Record::Metadata.new(
  adaptor: netsuite_adaptor, # Assuming this is previous defined
  record: :customer
)

puts metadata.http_methods # Returns a list of LedgerSync::Adaptors::NetSuite::Record::HTTPMethod objects
puts metadata.properties # Returns a list of LedgerSync::Adaptors::NetSuite::Record::Property objects
```

### Reference

- [NetSuite REST API Documentation](https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSTRW/NSTRW.pdf)

## NetSuite SOAP

LedgerSync supports the NetSuite SOAP adaptor, leveraging [the NetSuite gem](https://github.com/NetSweet/netsuite).  The adaptor and sample operations are provided, though the main NetSuite adaptor uses the REST API.

### Reference

- [NetSuite SOAP API Documentation](https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSTWR/NSTWR.pdf)


## QuickBooks Online

### OAuth

QuickBooks Online utilizes OAuth 2.0, which requires frequent refreshing of the access token.  The adaptor will handle this automatically, attempting a single token refresh on any single request authentication failure.  Depending on how you use the library, every adaptor has implements a class method `ledger_attributes_to_save`, which is an array of attributes that may change as the adaptor is used.  You can also call the instance method `ledger_attributes_to_save` which will be a hash of these values.  It is a good practice to always store these attributes if you are saving access tokens in your database.

The adaptor also implements some helper methods for getting tokens.  For example, you can set up an adaptor using the following:

```ruby
# Retrieve the following values from Intuit app settings
client_id     = 'ID'
client_secret = 'SECRET'
redirect_uri  = 'http://localhost:3000'

oauth_client = LedgerSync::Adaptors::QuickBooksOnline::OAuthClientHelper.new(
  client_id: client_id,
  client_secret: client_secret
)

puts oauth_client.authorization_url(redirect_uri: redirect_uri)

# Visit on the output URL and authorize a company.
# You will be redirected back to the redirect_uri.
# Copy the full url from your browser:

uri = 'https://localhost:3000/?code=FOO&state=BAR&realm_id=BAZ'

adaptor = LedgerSync::Adaptors::QuickBooksOnline::Adaptor.new_from_oauth_client_uri(
  oauth_client: oauth_client,
  uri: uri
)

# You can test that the auth works:

adaptor.refresh!
```

**Note: If you have a `.env` file storing your secrets, the adaptor will automatically update the variables and record previous values whenever values change**

### Webhooks

Reference: [QuickBooks Online Webhook Documentation](https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification)

LedgerSync offers an easy way to validate and parse webhook payloads.  It also allows you to easily fetch the resources referenced.  You can create and use a webhook with the following:

```ruby
# Assuming `request` is the webhook request received from Quickbooks Online
webhook = LedgerSync::Adaptors::QuickBooksOnline::Webhook.new(
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
    notification.find_operation_class(adaptor: your_quickbooks_adaptor_instance) # The respective Find class
    notification.find_operation(adaptor: your_quickbooks_adaptor_instance) # The initialized respective Find operation
    notification.find(adaptor: your_quickbooks_adaptor_instance) # Performs a Find operation for the resource retrieving the latest version from QuickBooks Online
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