# frozen_string_literal: true

require 'spec_helper'
require_relative '../../support/unit_testing_shared_examples'

module LedgerSync
  class Error
    RSpec.shared_examples 'a base error' do
      include_examples 'a required argument initializer', message: 'test', client: nil do
        let(:let_args) { { client: test_ledger_client } }
      end
    end

    RSpec.describe LedgerError do
      it_should_behave_like 'a base error'
    end

    class LedgerError
      [AuthenticationError, AuthorizationError, ConfigurationError].each do |sub_class|
        RSpec.describe sub_class do
          it_should_behave_like 'a base error'
        end
      end

      RSpec.describe MissingLedgerError do
        include_examples 'a required argument initializer', message: 'test'
      end

      RSpec.describe LedgerValidationError do
        it_should_behave_like 'a base error' do
          let(:let_args) do
            { client: test_ledger_client, attribute: 'test attribute', validation: 'test validation' }
          end
        end
      end

      RSpec.describe ThrottleError do
        include_examples 'a required argument initializer' do
          let(:let_args) { { client: test_ledger_client } }
        end

        describe '.message' do
          it 'should have a default message' do
            expect(described_class.new(client: test_ledger_client).message).to be_truthy
          end

          it 'should change default message when a custom message is provided' do
            test_message = 'test message'
            expect(described_class.new(client: test_ledger_client, message: test_message).message).to eq(test_message)
          end
        end

        describe '.response' do
          it 'should respond to "response" when provided' do
            test_response = 'test response'
            expect(described_class.new(
              client: test_ledger_client,
              response: test_response
            ).response).to eq(test_response)
          end
        end
      end

      RSpec.describe UnknownURLFormat do
        include_examples 'a required argument initializer' do
          let(:test_resource) do
            new_resource_class(
              attributes: %i[test_key]
            ).new(test_key: 'test_value')
          end

          let(:let_args) { { client: test_ledger_client, resource: test_resource } }
        end
      end
    end
  end
end
