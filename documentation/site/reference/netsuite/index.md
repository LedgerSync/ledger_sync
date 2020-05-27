---
title: NetSuite
layout: reference_netsuite
ledger: netsuite
---

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