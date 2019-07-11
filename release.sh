#!/bin/bash

if output=$(git status --porcelain) && [ -z "$output" ]; then
  bump $1 && git push && bundle exec rake build && bundle exec rake release
else
  echo 'PLEASE COMMIT ALL CHANGES BEFORE RELEASING.'
  exit 1
fi
