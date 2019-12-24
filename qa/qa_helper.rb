# frozen_string_literal: true

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

# Use ENV for adaptor secrets
require 'dotenv'
Dotenv.load

#
# Helper method for requiring support files
#
# @param [String] *paths List of strings or symbols
#
# @return [Boolean]
#
def support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'qa/support/', path.to_s)
  end
end

#
# Old method of uniqueness until we implement FactoryBot
# TODO: Remove when FactoryBot is implemented.
#
# @return [String]
#
def test_run_id
  @test_run_id ||= (0...8).map { rand(65..90).chr }.join
end

support :netsuite_helpers

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/qa_history.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include NetSuiteHelpers, adaptor: :netsuite
end
