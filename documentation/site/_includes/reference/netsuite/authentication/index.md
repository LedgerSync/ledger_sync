---
title: Authentication
layout: reference_netsuite
ledger: netsuite
---

For the REST API, NetSuite offers two types of authentication:

- Token Based Authentication (TBA)
- Oauth 2.0

This client currently uses TBA.  While Oauth 2.0 may be available in the future, TBA was chosen for the following reasons:

1. The SOAP API only supports TBA.
2. NetSuite users will still need to go through a manual setup (e.g. Integration record and Role) regardless of the method.