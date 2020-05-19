# frozen_string_literal: true

# Setup
#
# gem install bundler
# Ensure you have http://localhost:5678 (or PORT) as a Redirect URI in QBO.

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'simply_serializable'
  gem 'ledger_sync', path: '.'
  gem 'pd_ruby'
  gem 'colorize'
  gem 'byebug'
end

require 'ledger_sync'
require 'pd_ruby'
require 'erb'
require 'fileutils'

require_relative 'helper_methods'
require_relative 'generators/generator'
require_relative 'generators/guides_ledgers_generator'
require_relative 'generators/reference_resources_generator'

Docs::GuidesLedgersGenerator.new.generate
Docs::ReferenceResourcesGenerator.new.generate

green 'All done!'
