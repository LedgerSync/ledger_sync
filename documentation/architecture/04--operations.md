## Operations

Each ledger defines operations that can be performed on specific resources (e.g. `Customer::Operations::Update`
, `Payment::
Operations::Create`). The operation defines two key things:

- a `Contract` class which is used to validate the resource using the `dry-validation` gem
- a `perform` instance method, which handles the actual API requests and response/error handling.

> Note: Ledgers may support different operations for each resource type.

### Contracts

Contracts are dry-validation schemas, which determine if an operation can be performed. You can create custom schemas
and pass them to operations. Assuming you have an `operation_class` variable and `foo` is an attribute of a
`custom_resource` (see above) that is required to be a string, you can implement it with the following:

```ruby

class CustomContract < LedgerSync::Contract
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
