#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'
require 'yaml'

gemfile do
  source 'https://rubygems.org'
  gem 'byebug'
  # gem 'ledger_sync'
  gem 'ledger_sync', path: '/Users/ryanwjackson/dev/ledger_sync/ledger_sync'
  gem 'activemodel'
end

config_path = "#{__dir__}/.qa_config.yml"

unless File.file?(config_path)
  config_template = {
    'quickbooks_online' => {
      'access_token' => 'REQUIRED',
      'client_id' => 'REQUIRED',
      'client_secret' => 'REQUIRED',
      'realm_id' => 'REQUIRED',
      'refresh_token' => 'REQUIRED'
    }
  }
  File.open(config_path, 'w') { |file| file.write(config_template.to_yaml) }
  raise "Please fill out secret.yml located here:\n#{config_path}"
end

config = YAML.safe_load(File.read(config_path))

### START: Shortcuts

LS = LedgerSync
QBO = LS::Adaptors::QuickBooksOnline

### END: Shortcuts

### START: Helper Methods

def perform(op)
  if op.valid?
    result = op.perform
    byebug if op.failure?
    return result
  end

  raise op.validate
end

### END: Helper Methods

# TEST_RUN_ID = "#{Time.now}_#{(0...8).map { rand(65..90).chr }.join}"
TEST_RUN_ID = (0...8).map { rand(65..90).chr }.join

puts "Running Test: #{TEST_RUN_ID}"

adaptor = LedgerSync.adaptors.qbo.new(
  access_token: config['quickbooks_online']['access_token'],
  client_id: config['quickbooks_online']['client_id'],
  client_secret: config['quickbooks_online']['client_secret'],
  realm_id: config['quickbooks_online']['realm_id'],
  refresh_token: config['quickbooks_online']['refresh_token'],
  test: true
)
adaptor.refresh!

account = LS::Account.new(
  name: "Test Account #{TEST_RUN_ID}",
  classification: 'asset',
  account_type: 'bank',
  account_sub_type: 'cash_on_hand',
  currency: 'usd',
  description: "Test #{TEST_RUN_ID} Account description",
  active: true
)

result = perform(QBO::Account::Operations::Create.new(
  adaptor: adaptor,
  resource: account
))

account = result.resource

vendor = LS::Vendor.new(
  email: "test-#{TEST_RUN_ID}-vendor@example.com",
  first_name: "TestFirst#{TEST_RUN_ID}",
  last_name: "TestLast#{TEST_RUN_ID}",
  display_name: "Test #{TEST_RUN_ID} Display Name"
)

result = perform(QBO::Vendor::Operations::Create.new(
  adaptor: adaptor,
  resource: vendor
))

vendor = result.resource

expense_line_item_1 = LS::ExpenseLineItem.new(
  account: account,
  amount: 12_345,
  description: "Test #{TEST_RUN_ID} Line Item 1"
)

expense_line_item_2 = LS::ExpenseLineItem.new(
  account: account,
  amount: 23_456,
  description: "Test #{TEST_RUN_ID} Line Item 2"
)

expense = LS::Expense.new(
  currency: 'usd',
  memo: 'Testing',
  payment_type: 'cash',
  transaction_date: Date.today,
  exchange_rate: 1.0,
  vendor: vendor,
  account: account,
  line_items: [
    expense_line_item_1,
    expense_line_item_2
  ]
)
operation = QBO::Expense::Operations::Create.new(
  adaptor: adaptor,
  resource: expense
)

result = perform(operation)

pdb result.success?
byebug

puts "Writing secrets to secrets.yml...\n\n"

config['quickbooks_online']['access_token'] = adaptor.access_token
config['quickbooks_online']['refresh_token'] = adaptor.refresh_token

File.open(config_path, 'w') { |file| file.write(config.to_yaml) }

puts "BYE!\n\n"
