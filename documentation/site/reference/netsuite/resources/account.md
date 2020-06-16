---
title: account
weight: 1
layout: reference_netsuite
---

## LedgerSync::Ledgers::NetSuite::Account

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

### LedgerSync::Ledgers::NetSuite::Account::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::NetSuite::Account::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |

## Searchers

| Name |
| ---- |
| `LedgerSync::Ledgers::NetSuite::Account::Searcher` |
