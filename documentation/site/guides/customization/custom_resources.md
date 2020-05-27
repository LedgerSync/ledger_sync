---
title: Custom Resources
layout: guides
weight: 2
---

Some ledgers (e.g. NetSuite) allow for custom attributes (or "fields"), which can vary by account and user.  To allow for custom attributes, you can create new resources, ledger serializers (see below), and validation contracts (see below).  Assuming your ledger supports the string attribute `foo` for customers, you could do the following:

```ruby
class CustomCustomer < LedgerSync::Ledgers::QuickBooksOnline::Customer
  attribute :foo, type: LedgerSync::Type::String
end
```

Depending on your use of LedgerSync, you may need to define resources dynamically with different custom attributes.  You could do so using something like the following:

```ruby
custom_attributes_for_customers = [
  [
    [:foo, LedgerSync::Type::String]
  ],
  [
    [:foo, LedgerSync::Type::Integer],
    [:bar, LedgerSync::Type::Boolean]
  ]
]

custom_customer_classes = custom_attributes_for_customers.map do |attributes|
  customer_class = Class.new(LedgerSync::Ledgers::QuickBooksOnline::Customer)
  attributes.each do |name, type|
    customer_class.attribute name, type: type
  end
  customer_class
end

customer_class_1, customer_class_2 = custom_customer_classes

# First Custom Customer Class
customer_class_1.resource_attributes.include?(:foo) # => true
customer_class_1.resource_attributes[:foo].type # => #<LedgerSync::Type::String:0x00007fe04e9529b0 @precision=nil, @scale=nil, @limit=nil>
customer_class_1.resource_attributes.include?(:bar) # => false

# Second Custom Customer Class
customer_class_2.resource_attributes.include?(:foo) # => true
customer_class_2.resource_attributes[:foo].type # => #<LedgerSync::Type::Integer:0x00007fe04e2c7898 @precision=nil, @scale=nil, @limit=nil, @range=-2147483648...2147483648>
customer_class_2.resource_attributes.include?(:bar) # => true
customer_class_2.resource_attributes[:bar].type # => #<LedgerSync::Type::Boolean:0x00007fe04e2e4f10 @precision=nil, @scale=nil, @limit=nil>
```

You can now use these custom resources in operations that use or require custom attributes.
