#!/bin/bash

if output=$(git status --porcelain) && [ -z "$output" ]; then
  echo "Checking out master" && \
    git checkout master && \
    echo "Pulling latest from github" && \
    git pull origin master

  if output=$(git status --porcelain) && [ -z "$output" ]; then
    echo "Bumping version" && \
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

else
  >&2 echo 'PLEASE COMMIT ALL CHANGES BEFORE RELEASING.'
  exit 1
fi
