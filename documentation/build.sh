#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"
ruby generate.rb
cd site
bundle exec jekyll build -d ../../.