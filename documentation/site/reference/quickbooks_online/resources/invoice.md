---
title: invoice
weight: 13
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::Invoice

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

### LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Invoice::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |
