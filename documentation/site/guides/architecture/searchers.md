---
title: Operations
weight: 5
layout: guides
---

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