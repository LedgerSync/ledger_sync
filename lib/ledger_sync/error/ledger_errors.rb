# frozen_string_literal: true

module LedgerSync
  class Error
    class LedgerError < Error
      attr_reader :client, :response

      def initialize(client:, message:, response: nil)
        @client = client
        @response = response
        super(message: message)
      end

      class AuthenticationError < self; end
      class AuthorizationError < self; end
      class ConfigurationError < self; end

      class MissingLedgerError < self
        def initialize(message:)
          super(
            message: message,
            client: nil,
          )
        end
      end

      class LedgerValidationError < self
        attr_reader :attribute, :validation

        def initialize(message:, client:, attribute:, validation:)
          @attribute = attribute
          @validation = validation
          super(
            message: message,
            client: client,
          )
        end
      end

      class ThrottleError < self
        attr_reader :rate_limiting_wait_in_seconds

        def initialize(client:, message: nil, response: nil)
          message ||= 'Your request has been throttled.'
          @rate_limiting_wait_in_seconds = LedgerSync.ledgers.config_from_class(
            client_class: client.class
          ).rate_limiting_wait_in_seconds

          super(
            client: client,
            message: message,
            response: response
          )
        end
      end

      class UnknownURLFormat < self
        attr_reader :resource

        def initialize(resource:, **keywords)
          super(
            **{
              message: "Unknown URL format for #{resource.class}"
            }.merge(keywords)
          )
        end
      end
    end
  end
end
