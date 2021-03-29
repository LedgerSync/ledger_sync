# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  class Error

    RSpec.shared_examples 'error_message_initializer' do |**args|
      it 'should initialize when client and message is provided' do
        expect(described_class.new(client: test_ledger_client, message: 'test error', **args)).to be_a_kind_of(Error)
      end
    end

    RSpec.shared_examples 'basic_ledger_error' do |**args|
      describe '#initialize' do
        it_should_behave_like 'error_message_initializer', **args
      end

      it 'should not initialize when client is not provided' do
        expect { described_class.new(message: 'test error', **args) }.to raise_error(ArgumentError)
      end

      it 'should not initialize when message is not provided' do
        expect { described_class.new(client: test_ledger_client, **args) }.to raise_error(ArgumentError)
      end
    end

    RSpec.describe LedgerError do
      include_examples 'basic_ledger_error'
    end

    class LedgerError
      [AuthenticationError, AuthorizationError, ConfigurationError].each do |sub_class|
        RSpec.describe sub_class do
          include_examples 'basic_ledger_error'
        end
      end

      RSpec.describe LedgerValidationError do
        include_examples 'basic_ledger_error', attribute: 'test attribute', validation: 'test validation'

        it 'should not initialize when attribute is not provided' do
          expect { described_class.new(client: test_ledger_client, message: 'test_message', validation: 'test_validation') }.to raise_error(ArgumentError)
        end

        it 'should not initialize when validation is not provided' do
          expect { described_class.new(client: test_ledger_client, message: 'test_message', attribute: 'test_attribute') }.to raise_error(ArgumentError)
        end
      end

      RSpec.describe MissingLedgerError do
        it 'should not initialize when client is not provided' do
          # expect { described_class.new(message: 'test error') }.to raise_error(ArgumentError)
        end
      end

      RSpec.describe ThrottleError do
        it 'should initialize when client is provided' do
          expect(described_class.new(client: test_ledger_client)).to be_a_kind_of(Error)
        end

        it 'should have a default message' do
          expect(described_class.new(client: test_ledger_client).message).to be_truthy
        end

        it 'should change default message when a custom message is provided' do
          test_message = 'test message'
          expect(described_class.new(client: test_ledger_client, message: test_message).message).to eq(test_message)
        end

        it 'should respond to "response" when provided' do
          test_response = 'test response'
          expect(described_class.new(client: test_ledger_client, response: test_response).response).to eq(test_response)
        end
      end
    end
  end
end
