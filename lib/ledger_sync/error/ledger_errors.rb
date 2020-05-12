# frozen_string_literal: true

module LedgerSync
  class Error
    class LedgerError < Error
      attr_reader :connection
      attr_reader :response

      def initialize(connection:, message:, response: nil)
        @connection = connection
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
            connection: nil,
          )
        end
      end

      class LedgerValidationError < self
        attr_reader :attribute, :validation

        def initialize(message:, connection:, attribute:, validation:)
          @attribute = attribute
          @validation = validation
          super(
            message: message,
            connection: connection,
          )
        end
      end

      class ThrottleError < self
        attr_reader :rate_limiting_wait_in_seconds

        def initialize(connection:, message: nil, response: nil)
          message ||= 'Your request has been throttled.'
          @rate_limiting_wait_in_seconds = LedgerSync.ledgers.config_from_class(
            connection_class: connection.class
          ).rate_limiting_wait_in_seconds

          super(
            connection: connection,
            message: message,
            response: response
          )
        end
      end

      class UnknownURLFormat < self
        attr_reader :resource

        def initialize(*args, resource:, **keywords)
          super(
            *args,
            {
              message: "Unknown URL format for #{resource.class}"
            }.merge(keywords)
          )
        end
      end
    end
  end
end
