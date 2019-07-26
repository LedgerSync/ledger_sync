#!/bin/bash

if output=$(git status --porcelain) && [ -z "$output" ]; then
  bundle exec bump $1 && \
    echo "Pushing to github" && \
    git push && \
    echo "Building gem" && \
    bundle exec rake build && \
    echo "Releasing gem" && \
    bundle exec rake release
else
  >&2 echo 'PLEASE COMMIT ALL CHANGES BEFORE RELEASING.'
  exit 1
fi
