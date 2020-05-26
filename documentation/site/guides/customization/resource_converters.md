---
title: Resource Converters
layout: guides
weight: 1
---

## Overview

LedgerSync provides ledger-specific resources and operations for you to easily interface with a ledger.  Complexity arises for a few reasons, such as the following:

- Ledgers have different resources.  Some ledgers may not even implement the same resources as another ledger.
- Resources for a given ledger have different attributes from their counterparts in other ledgers.
- Operations may not be supported in all ledgers (e.g. deletion is not available for some resources in QuickBooks Online)
- etc.

Because of this complexity, LedgerSync tries to remain "unopinionated" about ledgers.  The goal is to have resources, attributes, and operations that match as closely to the API as possible.  The issue here is that it requires a developer to have ledger-specific knowledge for every interaction with LedgerSync or to define new resource, operation, and validation layers entirely.

To solve this problem, some engineers at [Modern Treasury](site.modern_treasury_url) have created what we call a `ResourceConverter`.  This object takes in a `source` and `destination`.  It also defines the mapping from source to destination.  This makes it easy to take any object and map it to a ledger-specific resource.  Having a converter per resource per ledger enables you to create an interface with LedgerSync.  After this layer is created, future developers are not required to have ledger-specific knowledge to make updates.

Let's see how this works.

## Scenario

Let's assume that we have a `Customer` model object that we use internally that looks like the following:

```ruby
class Customer
  attr_accessor :name
  attr_accessor :email
  attr_accessor :id
end
```

We want to sync the data on this object (specifically `name`, `email`, and `id`) to QuickBooks Online and NetSuite.  We will also assume that we have already handled authentication and have a valid client for each(`quickbooks_online_client` and `netsuite_client`, respectively).  Both ledgers implement their own `Customer` object, but the attributes for these objects vary.  For example, here are the relevant snippets of these resources:

```ruby
module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer < QuickBooksOnline::Resource
        attribute :DisplayName, type: LedgerSync::Type::String

        references_one :PrimaryEmailAddr, to: PrimaryEmailAddr
      end
    end
  end
end

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PrimaryEmailAddr < QuickBooksOnline::Resource
        attribute :Address, type: LedgerSync::Type::String
      end
    end
  end
end
```

```ruby
module LedgerSync
  module Ledgers
    module NetSuite
      class Customer < NetSuite::Resource
        attribute :email, type: LedgerSync::Type::String
        attribute :companyName, type: LedgerSync::Type::String
        attribute :firstName, type: LedgerSync::Type::String
        attribute :lastName, type: LedgerSync::Type::String
      end
    end
  end
end
```

<div class="note"><strong>Note:</strong>
<p>
  We will ignore for the purposes of this guide that NetSuite requires a `subsidiary` for their `Customer` resource.
</p>
</div>