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
  gem 'httplog'
end

require 'httplog'

HttpLog.configure do |config|
  config.color = { color: :black, background: :yellow }
  config.compact_log = true
  config.log_headers = true
end

### START: Config

config_path = "#{__dir__}/.qa_config.yml"

unless File.file?(config_path)
  config_template = {
    'netsuite' => {
      'account_id' => 'REQUIRED',
      'consumer_key' => 'REQUIRED',
      'consumer_secret' => 'REQUIRED',
      'token_id' => 'REQUIRED',
      'token_secret' => 'REQUIRED'
    },
    'netsuite_rest' => {
      'account_id' => 'REQUIRED',
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

### START: Run Tests

test_suites = [
  QA::NetSuiteTest,
  QA::QuickBooksOnlineTest,
  QA::StripeTest,
  QA::NetSuiteRESTTest
]

test_suite_ids = test_suites.count.times.map(&:to_s)

loop do
  puts 'Test Suites'
  test_suites.each_with_index do |suite, i|
    puts "#{i}. #{suite.name}"
  end
  puts 'Please enter the number of the test suite to run:'
  chosen_suite = gets.chomp
  break unless test_suite_ids.include?(chosen_suite)

  suite_class_to_run = test_suites[chosen_suite.to_i]

  suite_to_run = suite_class_to_run.new(config: config, test_run_id: TEST_RUN_ID)
  puts "Running: #{suite_class_to_run.name}"
  suite_to_run.run
  puts "Finished: #{suite_class_to_run.name}"
  next unless config != suite_to_run.config

  config = suite_to_run.config
  puts 'Starting: Updating secrets...'
  File.open(config_path, 'w') { |file| file.write(config.to_yaml) }
  puts 'Completed: Updating secrets...'
end

puts "BYE!\n\n"
