---
title: Console
layout: guides
---

<div class="note"><strong>Note:</strong>
Only contributors can deploy new versions of the gem to RubyGems.org.
</div>

To deploy a new version of the gem to RubyGems, you can use the `release.sh` script in the root.  The script takes advantage of [the bump gem](https://github.com/gregorym/bump).  So you may call the script using any of the following:

```bash
# Version Format: MAJOR.MINOR.PATCH
./release.sh patch # to bump X in 1.1.X
./release.sh minor # to bump X in 1.X.1
./release.sh major # to bump X in X.1.1
```