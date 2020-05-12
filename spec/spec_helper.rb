# frozen_string_literal: true

require 'webmock/rspec'
require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
)

SimpleCov.start do
  add_filter 'lib/ledger_sync/util/debug.rb'
end

# Set an environment variable to determine when we are testing.  This
# prevents things like the QuickBooks Online connection overwriting
# environment variables with dummy values.
ENV['TEST_ENV'] = 'true'

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

def support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/support/', path.to_s)
  end
end

support :factory_bot
support :webmock_helpers
support :vcr

def qa_support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/qa/support/', path.to_s)
  end
end
qa_support :ledger_support_qa_setup

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/rspec_history.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
