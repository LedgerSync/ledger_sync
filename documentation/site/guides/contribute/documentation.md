---
title: Documentation
excerpt: >-
  Learn how to document and update the documentation site.
layout: guides
---

## Overview

Our documentation is a static website hosted on Github pages.  The docs are a mix of static and dynamically-generated
content.  The final static site is generated using Jekyll.

## Install Jekyll

To run or generate the docs site locally, you need to install Jekyll:

```
gem install jekyll bundler
```

## Run Jekyll

To run Jekyll locally to view the site, run the following from the root directory:

```
cd docs/site
bundle exec jekyll serve
```

## Generate dynamic pages

Some of the documentation is generated based on the code of LedgerSync (e.g. available operations, resources, etc.). To
generate these pages, run the following from the root directory:

```
ruby docs/generate.rb
```