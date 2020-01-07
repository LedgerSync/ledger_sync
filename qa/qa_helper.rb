# frozen_string_literal: true

# Set an environment variable to determine when we are running QA tests.
ENV['QA_ENV'] = 'true'

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

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
# Helper method for requiring support files from /spec/support dir
#
# @param [String] *paths List of strings or symbols
#
# @return [Boolean]
#
def spec_support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/support/', path.to_s)
  end
end

spec_support :factory_bot

support :adaptor_support_setup

setup_adaptor_support(
  LedgerSync::Adaptors::NetSuite::Adaptor,
  LedgerSync::Adaptors::NetSuiteSOAP::Adaptor,
  LedgerSync::Adaptors::QuickBooksOnline::Adaptor,
  LedgerSync::Adaptors::Stripe::Adaptor
)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/qa_history.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
