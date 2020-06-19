---
title: bill
weight: 2
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::Bill

## Attributes

| Name | Type |
| ---- | ---- |
| external_id | LedgerSync::Type::ID |
| ledger_id | LedgerSync::Type::ID |
| memo | LedgerSync::Type::String |
| transaction_date | LedgerSync::Type::Date |
| due_date | LedgerSync::Type::Date |
| reference_number | LedgerSync::Type::String |
| vendor | LedgerSync::Type::ReferenceOne |
| account | LedgerSync::Type::ReferenceOne |
| department | LedgerSync::Type::ReferenceOne |
| currency | LedgerSync::Type::ReferenceOne |
| line_items | LedgerSync::Type::ReferenceMany |


## Operations

### LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Bill::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |

## Searchers

| Name |
| ---- |
| `LedgerSync::Ledgers::QuickBooksOnline::Bill::Searcher` |
