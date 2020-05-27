---
title: QA
layout: guides
---

**BE SURE TO USE A TEST ENVIRONMENT ON YOUR LEDGER.**

To fully test the library against the actual ledgers, you can run `bin/qa` which will run all tests in the `qa/` directory.  QA Tests are written in RSpec.  Unlike tests in the `spec/` directory, QA tests allow external HTTP requests.

As these interact with real ledgers, you will need to provide secrets.  You can do so in a `.env` file in the root directory.  Copy the `.env.template` file to get started.

**WARNINGS:**

- **BE SURE TO USE A TEST ENVIRONMENT ON YOUR LEDGER.**
- **NEVER CHECK IN YOUR SECRETS (e.g. the `.env` file).**
- Because these tests actually create and modify resources, they attempt to do "cleanup" by deleting any newly created resources.  This process could fail, and you may need to delete these resources manually.