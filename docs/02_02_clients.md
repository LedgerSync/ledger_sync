## Clients

### Overview

Clients handle the authentication and requests to the ledger. A ledger may have different authentication strategies, so
clients will accept different arguments. For example, QuickBooks Online utilizes Oauth 2.0 while NetSuite offers Token
Based Authentication. While similar, the required keys are different.

### How to use

Unless you are customizing LedgerSync, you will always pass an instantiated client to an object (e.g. an operation). The
object will handle using the client as needed.

As most clients implement basic request functionality (e.g. `get`, `put`, `post`, `delete`, etc.), you can call these
methods directly to perform custom requests. Refer to the specific Client definitions for what parameters are permitted.

### Gotchas

#### Oauth 2.0

Clients store the authentication details for the ledger. Given that Oauth 2.0 tokens can refresh during a request, these
clients will handle saving credentials back to the client instance. Typically (though some clients offer more automated
solutions), you will want to save any changes back to your database. You can use `client.ledger_attributes_to_save` to
retrieve a hash of which attributes to save. Your code to do so could look like the following:

```ruby
# Assuming `client` is defined as an instance of a ledger Client class
client.ledger_attributes_to_save.each do |attribute_to_save, value|
  # Store value
end
```