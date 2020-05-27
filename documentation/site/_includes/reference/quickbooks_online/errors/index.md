---
title: Errors
layout: reference_quickbooks_online
ledger: quickbooks_online
---

While LedgerSync tries to catch and translate errors, not all errors will be caught.  In these cases, you can resque a generic `LedgerSync::OperationError` and determine what to do based on the response body.

[QuickBooks Online Error Documentation](https://developer.intuit.com/app/developer/qbo/docs/develop/troubleshooting/error-codes)