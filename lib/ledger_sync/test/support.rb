# frozen_string_literal: true

def support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/support/', path.to_s)
  end
end

def core_support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'lib/ledger_sync/test/support/', path.to_s)
  end
end

def qa_support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/qa/support/', path.to_s)
  end
end

module LedgerSync
  module Test
    module Support
      def self.setup(*paths_to_require)
        require 'webmock/rspec'
        require 'simplecov'
        require 'coveralls'
        Coveralls.wear!

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
        # prevents things like the QuickBooks Online client overwriting
        # environment variables with dummy values.
        ENV['TEST_ENV'] = 'true'

        require 'bundler/setup'
        require 'ap'
        require 'byebug'

        paths_to_require.each { |e| require e.to_s }

        # Include test adaptor
        require File.join(LedgerSync.root, 'spec/support/test_ledger/config')

        core_support :factory_bot

        RSpec.configure do |config|
          # Enable flags like --only-failures and --next-failure
          config.example_status_persistence_file_path = 'tmp/rspec_history.txt'

          # Disable RSpec exposing methods globally on `Module` and `main`
          config.disable_monkey_patching!

          config.expect_with :rspec do |c|
            c.syntax = :expect
          end
        end
      end
    end
  end
end
