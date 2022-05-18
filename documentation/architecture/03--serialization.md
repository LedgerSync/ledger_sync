# Serializers

Serializers take a [Resource](02--resources.md) and output a hash. For example:

```ruby
customer = LedgerSync::NetSuite::Customer.new(
  companyName: 'Test Company',
  external_id: 'ext_123'
)
serializer = LedgerSync::NetSuite::Customer::Serializer.new
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
