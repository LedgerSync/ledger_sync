---
title: account
weight: 1
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::Account

## Attributes

| Name | Type |
| ---- | ---- |
| external_id | LedgerSync::Type::ID |
| ledger_id | LedgerSync::Type::ID |
| name | LedgerSync::Type::String |
| classification | LedgerSync::Type::String |
| account_type | LedgerSync::Type::StringFromSet |
| account_sub_type | LedgerSync::Type::String |
| number | LedgerSync::Type::String |
| description | LedgerSync::Type::String |
| active | LedgerSync::Type::Boolean |
| currency | LedgerSync::Type::ReferenceOne |


## Operations

### LedgerSync::Ledgers::QuickBooksOnline::Account::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Account::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::Account::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |

## Searchers

| Name |
| ---- |
| `LedgerSync::Ledgers::QuickBooksOnline::Account::Searcher` |
