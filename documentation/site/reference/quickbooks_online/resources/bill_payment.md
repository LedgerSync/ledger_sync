---
title: bill_payment
weight: 4
layout: reference_quickbooks_online
---

## LedgerSync::Ledgers::QuickBooksOnline::BillPayment

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
| payment_type | LedgerSync::Type::StringFromSet |
| account | LedgerSync::Type::ReferenceOne |
| currency | LedgerSync::Type::ReferenceOne |
| department | LedgerSync::Type::ReferenceOne |
| vendor | LedgerSync::Type::ReferenceOne |
| bank_account | LedgerSync::Type::ReferenceOne |
| credit_card_account | LedgerSync::Type::ReferenceOne |
| line_items | LedgerSync::Type::ReferenceMany |


## Operations

### LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Find

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Create

#### Resource Validations

| Name | Type |
| ---- | ---- |
### LedgerSync::Ledgers::QuickBooksOnline::BillPayment::Operations::Update

#### Resource Validations

| Name | Type |
| ---- | ---- |

## Searchers

There are no searchers for this resource.
