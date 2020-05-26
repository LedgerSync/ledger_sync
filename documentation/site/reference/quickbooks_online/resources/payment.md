---
title: payment
weight: 19
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::Payment

## Attributes

| Name | Type |
| ---- | ---- |
| external_id | LedgerSync::Type::ID |
| ledger_id | LedgerSync::Type::ID |
| amount | LedgerSync::Type::Integer |
| memo | LedgerSync::Type::String |
| transaction_date | LedgerSync::Type::Date |
| exchange_rate | LedgerSync::Type::Float |
| reference_number | LedgerSync::Type::String |
| customer | LedgerSync::Type::ReferenceOne |
| deposit_account | LedgerSync::Type::ReferenceOne |
| account | LedgerSync::Type::ReferenceOne |
| currency | LedgerSync::Type::ReferenceOne |
| line_items | LedgerSync::Type::ReferenceMany |


## Operations

### LedgerSync::Ledgers::QuickBooksOnline::Payment::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Payment::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Payment::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |
