#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'
require 'yaml'

require_relative 'qa/test'
Dir['./qa/**/*.rb'].each { |path| require path[0..-4] }

gemfile do
  source 'https://rubygems.org'
  gem 'byebug'
  # gem 'ledger_sync'
  gem 'ledger_sync', path: '/Users/ryanwjackson/dev/ledger_sync/ledger_sync'
  gem 'activemodel'
end

### START: Config

config_path = "#{__dir__}/.qa_config.yml"

unless File.file?(config_path)
  config_template = {
    'netsuite' => {
      'account' => 'REQUIRED',
      'consumer_key' => 'REQUIRED',
      'consumer_secret' => 'REQUIRED',
      'token_id' => 'REQUIRED',
      'token_secret' => 'REQUIRED'
    },
    'quickbooks_online' => {
      'access_token' => 'REQUIRED',
      'client_id' => 'REQUIRED',
      'client_secret' => 'REQUIRED',
      'realm_id' => 'REQUIRED',
      'refresh_token' => 'REQUIRED'
    },
    'stripe' => {
      'api_key' => 'REQUIRED'
    }
  }
  File.open(config_path, 'w') { |file| file.write(config_template.to_yaml) }
  raise "Please fill out secret.yml located here:\n#{config_path}"
end

config = YAML.safe_load(File.read(config_path))

### End: Config

### END: Test Details

TEST_RUN_ID = (0...8).map { rand(65..90).chr }.join

puts "Running Test: #{TEST_RUN_ID}"

### END: Test Details

qbo_qa_test = QA::QuickBooksOnlineTest.new(config: config, test_run_id: TEST_RUN_ID)
qbo_qa_test.run
config = qbo_qa_test.config

puts "Writing updated QBO secrets.yml...\n\n"
File.open(config_path, 'w') { |file| file.write(config.to_yaml) }

config = QA::StripeTest.new(config: config, test_run_id: TEST_RUN_ID).run

puts "BYE!\n\n"
