---
title: invoice
weight: 10
layout: reference_netsuite
---

## LedgerSync::Ledgers::NetSuite::Invoice

## Attributes

| Name | Type |
| ---- | ---- |
| external_id | LedgerSync::Type::ID |
| ledger_id | LedgerSync::Type::ID |
| memo | LedgerSync::Type::String |
| transaction_date | LedgerSync::Type::Date |
| deposit | LedgerSync::Type::Integer |
| customer | LedgerSync::Type::ReferenceOne |
| account | LedgerSync::Type::ReferenceOne |
| currency | LedgerSync::Type::ReferenceOne |
| line_items | LedgerSync::Type::ReferenceMany |


## Operations

