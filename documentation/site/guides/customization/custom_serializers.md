---
title: Custom Serializers
layout: guides
weight: 2
---

When you need to pass new attributes to/from a ledger, you may to to create custom serializers and deserializers.

For example, given the following:

- `CustomCustomer` is a custom resource that inherits from `LedgerSync::Ledgers::NetSuite::Customer` and defines a custom attribute string named `foo`
- the attribute `foo` is used in both the request and response bodies
- `client` defines a valid instance of the NetSuite client


```ruby
class CustomSerializer < LedgerSync::Ledgers::NetSuite::Customer::Serializer
  attribute :foo
end

class CustomDeserializer < LedgerSync::Ledgers::NetSuite::Customer::Deserializer
  attribute :foo
end

# Serializing
custom_resource = CustomCustomer.new(foo: 'asdf') # See above under Resources -> Custom Attributes
serializer = CustomSerializer.new(resource: custom_resource)
serializer.serialize # => {..., "foo"=>"asdf",...}

# Deserializing
deserialized_resource = serializer.deserialize(hash: { foo: 'qwerty' }, resource: CustomCustomer.new)
deserialized_resource.foo # => 'qwerty'
custom_resource.foo # => 'asdf'

op = LedgerSync::Ledgers::NetSuite::Customer::Operations::Create.new(
  client: client,
  deserializer: CustomSerializer.new,
  serializer: CustomSerializer.new,
  resource: custom_resource
)
```

Note that in the above example, we extend an existing customer serializer in the NetSuite ledger.  In most cases, serializers have the following inheritance pattern: `LedgerSync::Ledgers::[ADAPTOR]::[RESOURCE]::Serializer <  LedgerSync::Ledgers::[ADAPTOR]::Serializer <  LedgerSync::Serializer`.

So in this example, it would be `LedgerSync::Ledgers::NetSuite::Customer::Serializer <  LedgerSync::Ledgers::NetSuite::Serializer <  LedgerSync::Serializer`.  The more specific the serializer, the more helper methods are available that are ledger and/or resource specific.

Similarly, deserializers follow the same pattern.
