# frozen_string_literal: true

# Setup
#
# gem install bundler
# Ensure you have http://localhost:5678 (or PORT) as a Redirect URI in QBO.

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'simply_serializable'
  gem 'ledger_sync', path: '../'
  # gem 'jekyll'
  # gem 'jekyll-menus'
  # gem 'jekyll-paginate'
  # gem 'jekyll-paginate-v2'
  gem 'pd_ruby'
  gem 'rainbow'
  gem 'byebug'
end

require 'ledger_sync'
require 'pd_ruby'
require 'erb'
require 'fileutils'
# require 'jekyll'
# require 'jekyll-menus'
# require 'jekyll-paginate'
# require 'jekyll-paginate-v2'

require_relative 'helper_methods'
require_relative 'generators/generator'
require_relative 'generators/guides/generator'
require_relative 'generators/reference/generator'

Docs::Guides::Generator.new.generate
Docs::Reference::Generator.new.generate

green 'All jekyll templates generated!'
