## Serialization

### Overview

LedgerSync leverages serialization and deserialization to convert resources into the necessary hash formats the ledger
expects. Generally, each resource will have 1 serializer and 1 deserializer.

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

### How to use

Serializers and deserializers are automatically inferred by each operation based on the naming convention. It is
possible to create your own serializers. Please see Customization for more.