---
title: deposit
weight: 9
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::Deposit

## Attributes

| Name | Type |
| ---- | ---- |
| external_id | LedgerSync::Type::ID |
| ledger_id | LedgerSync::Type::ID |
| memo | LedgerSync::Type::String |
| transaction_date | LedgerSync::Type::Date |
| exchange_rate | LedgerSync::Type::Float |
| account | LedgerSync::Type::ReferenceOne |
| department | LedgerSync::Type::ReferenceOne |
| currency | LedgerSync::Type::ReferenceOne |
| line_items | LedgerSync::Type::ReferenceMany |


## Operations

### LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |

## Searchers

| Name |
| ---- |
| `LedgerSync::Ledgers::QuickBooksOnline::Deposit::Searcher` |
