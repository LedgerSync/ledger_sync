#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"
cd ..
bundle install
gem install jekyll jekyll-menus jekyll-paginate jekyll-paginate-v2
cd documentation
ruby generate.rb
cd site
jekyll build -d ../../docs