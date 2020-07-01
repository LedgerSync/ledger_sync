---
title: New Release
layout: guides
---

<div class="note"><strong>Note:</strong>
Only owners can release new versions of the gem to RubyGems.org.
</div>

## 1. Pull latest development

```bash
git checkout development
git pull origin development
```

## 3. Start release

This assumes you are using [the git-flow gem](https://github.com/nvie/gitflow):

```bash
git flow release start vX.X.X # Replace X.X.X. with new version
```

## 2. Update version

You can use [the bump gem](https://github.com/gregorym/bump) to easily update the gem version:

```bash
# Version Format: MAJOR.MINOR.PATCH
# Choose one of the following
bundle exec bump patch # to bump X in 1.1.X
bundle exec bump minor # to bump X in 1.X.1
bundle exec bump major # to bump X in X.1.1

git commit -am "Publish version X.X.X"
```

## 3. Publish version

```bash
git flow release publish vX.X.X # Replace X.X.X. with new version
```

## 4. Create PR

Create a PR in the github repo with `master` as the base.

## 5. Wait for review and tests to pass.

All releases should be approved and NOT merged using github.

## 6. Merge release

Merge the release using git-flow:

```bash
git flow release finish vX.X.X # Replace X.X.X. with new version
git push origin --tags
```

## 7. Deploy new version to rubygems

```bash
git checkout master
bundle exec build
bundle exec release
```

## That's it!

The version will now be available [on rubygems](https://rubygems.org/gems/ledger_sync).