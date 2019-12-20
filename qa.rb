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
  # config.compact_log = true
  config.log_connect   = true
  config.log_request   = true
  config.log_headers   = true
  config.log_data      = true
  config.log_status    = true
  config.log_response  = true
  config.log_benchmark = true
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
    'netsuite' => {
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

### START: Run Tests

@test_suites = [
  QA::NetSuiteTest,
  QA::QuickBooksOnlineTest,
  QA::StripeTest,
  QA::NetSuiteTest
]

@test_suite_ids = @test_suites.count.times.map(&:to_s)

def valid_suite_id?(id)
  @test_suite_ids.include?(id.to_s)
end

def run_suite(config:, suite:)
  puts "Running: #{suite.class.name}"
  suite.run
  puts "Finished: #{suite.class.name}"
  return config unless config != suite.config

  config = suite.config
  puts 'Starting: Updating secrets...'
  File.open(config_path, 'w') { |file| file.write(config.to_yaml) }
  puts 'Completed: Updating secrets...'
  config
end

def run_suite_by_id(config:, id:)
  raise 'Invaid test suite id' unless valid_suite_id?(id)

  suite_class_to_run = @test_suites[id.to_i]
  run_suite(config: config, suite: suite_class_to_run.new(config: config))
end

if valid_suite_id?(ARGV[0])
  run_suite_by_id(config: config, id: ARGV[0])
else
  loop do
    puts 'Test Suites'
    @test_suites.each_with_index do |suite, i|
      puts "#{i}. #{suite.name}"
    end
    puts 'Please enter the number of the test suite to run:'
    chosen_suite_id = STDIN.gets.chomp
    break unless valid_suite_id?(chosen_suite_id)

    config = run_suite_by_id(chosen_suite_id)
  end
end

puts "BYE!\n\n"
