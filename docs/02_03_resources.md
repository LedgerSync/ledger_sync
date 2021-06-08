## Resources

### Overview

Resources are named ruby objects (e.g. `Customer`, `Payment`, etc.) with strict attributes (e.g. `name`, `amount`, etc.)
. LedgerSync provides resources specific to each ledger. While it is possible to create your own resources (see
Customization for more details), this section refers to provided ledger-specific resources.

The library strives to make each resource and attribute name match the ledger API. This naming convention will help you
more readily match ledger documentation to LedgerSync resources.

Every resource, regardless of ledger, implements a `ledger_id` and `external_id` attribute. The `ledger_id` is the ID
given by the ledger, while the `external_id` is your internal ID for the resource.

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

### Available resources

You can see all resources available for a given ledger by calling `resources` on the ledger’s Client like so:

`LedgerSync::Ledgers::QuickBooksOnline::Client.resources`

This returns a hash of resource types to classes, where the resource types are unique (e.g. `customer`, `vendor`, etc.).

You can see all resources available in LedgerSync by calling `LedgerSync.resources`. This returns an array (note: not a
hash as multiple ledgers have the same types) of resource classes that have been created inheriting the `LedgerSync::
Resource` class.

### Resource Attributes

Resources have defined attributes. Attributes are explicitly defined. An error is thrown if an unknown attribute is
passed to it. You can retrieve the attributes of a resource by calling `Customer.attributes`.

A subset of these `attributes` may be a `reference`, which is simply a special type of attribute that references another
resource. You can retrieve the references of a resource by calling `Customer.references`.