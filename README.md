# LedgerSync

[![Build
Status](https://travis-ci.org/LedgerSync/ledger_sync.svg?branch=master)](https://travis-ci.org/LedgerSync/ledger_sync)
[![Gem Version](https://badge.fury.io/rb/ledger_sync.svg)](https://badge.fury.io/rb/ledger_sync)
[![Coverage
Status](https://coveralls.io/repos/github/LedgerSync/ledger_sync/badge.svg?branch=master)](https://coveralls.io/github/LedgerSync/ledger_sync?branch=master)

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'ledger_sync'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ledger_sync

# Usage

The easiest entry point into the library is the `Sync` class, which will handle building, validating, and performing all the necessary operations to sync an object.  You can of course build and manage these primitives yourself if you require more control.  Here is an example of a sync:

```ruby
sync = LedgerSync::Sync.new(
  adaptor: adaptor, # The adaptor for the ledger you want to use (see below)
  method: :upsert,
  resources_data: resources_data, # The structured hash of resource data (see below)
  resource_external_id: resource_external_id, # The root object ID on which the operation is to be performed
  resource_type: resource_type # The root object type on which the operation is to be performed
)

sync.operations # Returns the ordered list of operations to be performed

sync.perform # Returns a SyncResult (either ::Success or ::Failure)
```

**NOTE: Even when not performing the sync (`sync.perform`) and just retrieving the operations (`sync.operations`), the library will make API requests to the ledger in order to determine if a `create` or `update` is necessary for each object involved.**

# How it Works

## The Library Structure

This library consists of two important layers:

1. Resources
2. Adaptors

### Resources

Resources are named ruby objects (e.g. `Customer`, `Payment`, etc.) with strict attributes (e.g. `name`, `amount`, etc.).  They are a layer between your application and an adaptor.  They can be validated using an adaptor.  You can create and use the resources, and an adaptor will update resources as needed based on the intention and outcome of that operation.

You can find supported resources by calling `LedgerSync.resources`.

Resources have defined attributes.  Attributes are explicitly defined.  An error is thrown if an unknown attribute is passed to it.  You can retrieve the attributes of a resource by calling `LedgerSync::Customer.attributes`.

A subset of these `attributes` may be a `reference`, which is simply a special type of attribute that references another resource.  You can retrieve the references of a resource by calling `LedgerSync::Customer.references`.

## Adaptors

Adaptors are ledger-specific ruby objects that contain all the logic to authenticate to a ledger, perform ledger-specific operations, and validate resources based on the requirements of the ledger.  Adaptors contain a number of useful objects:

- adaptor
- operations
- searchers

### Adaptor

The adaptor handles authentication and requests to the ledger.  Each adaptors initializer will vary based on the needs of that ledger.

### Operation

Each adaptor defines operations that can be performed on specific resources (e.g. `Customer::Update`, `Payment::Create`).  The operation defines three key things:

- a `Contract` class which is used to validate the resource using the `dry-validation` gem
- a `build` instance method, which handles any pre-processing to be done before the operation is performed (e.g. converting an `Upsert` into a `Create` or `Update`)
- a `perform` instance method, which handles the actual API requests and response/error handling.

Note: Adaptors may support different operations for each resource type.

### Searcher

Searchers are a classes that make it easy to search objects in the ledger.  A searcher takes an `adaptor`, `query` string and optional `pagination` hash.

# Tips and More!

## Keywords

LedgerSync heavily uses ruby keywords so as to make it clear what values are being passed and which attributes are required.  When this README says something like "the `fun_function` function takes the argument `foo`" that translates to `fun_function(foo: :some_value)`.

## Fingerprints

Most objects in LedgerSync can be fingerprinted by calling the instance method `fingerprint`.  For example:

```ruby
puts LedgerSync::Customer.new.fingerprint # "b3eab7ec00431a4ae0468fee72e5ba8f"

puts LedgerSync::Customer.new.fingerprint == LedgerSync::Customer.new.fingerprint # true
puts LedgerSync::Customer.new.fingerprint == LedgerSync::Customer.new(name: :foo).fingerprint # false
puts LedgerSync::Customer.new.fingerprint == LedgerSync::Payment.new.fingerprint # false
```

Fingerprints are used to compare objects.  This method is used in de-duping objects, as it only considers the data inside and not the instance itself (as shown above).

## Serialization

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
        sync_token: nil
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
        ledger_id: nil,
        sync_token: nil
      }
    }
  }
}
```

The serialization of any object follows the same struction.  There is a `:root` key that holds the ID of the root object.  There is also an `:objects` hash that contains all of the objects for this serialization.  As you can see, unique nested objects listed in the `:objects` hash and referenced using a "reference object", in this case:

```ruby
{
  object: "reference",
  id: "LedgerSync::Customer/b3eab7ec00431a4ae0468fee72e5ba8f"
}
```

# Testing

LedgerSync offers a test adaptor `LedgerSync::Adaptors::Test` that you can easily use and stub without requiring API requests.  For example:

```ruby
resources_data = {
  {
    customer: {
      'cus_1': {
        name: 'Jane Doe'
      }
    }
  }
}
sync = LedgerSync::Sync.new(
  adaptor: LedgerSync::Adaptors::Test.new,
  method: :upsert,
  resources_data: resources_data,
  resource_external_id: 'cus_1',
  resource_type: :customer
)

expect(sync.perform).to be_a(LedgerSync::SyncResult::Success)
```

# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Run `bundle console` to start and interactive console with the library already loaded.

### Adding an Adaptor

## Errors

https://developer.intuit.com/app/developer/qbo/docs/develop/troubleshooting/error-codes

#### Directory Structure

/quickbooks_online/
  adaptor.rb
  operations/
    customer/
      operation.rb


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LedgerSync/ledger_sync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LedgerSync project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/LedgerSync/ledger_sync/blob/master/CODE_OF_CONDUCT.md).
