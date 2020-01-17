# frozen_string_literal: true

module LedgerSync
  class Error
    class AdaptorError < Error
      attr_reader :adaptor
      attr_reader :response

      def initialize(adaptor:, message:, response: nil)
        @adaptor = adaptor
        @response = response
        super(message: message)
      end

      class AuthenticationError < self; end
      class AuthorizationError < self; end
      class ConfigurationError < self; end

      class MissingAdaptorError < self
        def initialize(message:)
          super(
            message: message,
            adaptor: nil,
          )
        end
      end

      class AdaptorValidationError < self
        attr_reader :attribute, :validation

        def initialize(message:, adaptor:, attribute:, validation:)
          @attribute = attribute
          @validation = validation
          super(
            message: message,
            adaptor: adaptor,
          )
        end
      end

      class ThrottleError < self
        attr_reader :rate_limiting_wait_in_seconds

        def initialize(adaptor:, message: nil, response: nil)
          message ||= 'Your request has been throttled.'
          @rate_limiting_wait_in_seconds = LedgerSync.adaptors.config_from_klass(
            klass: adaptor.class
          ).rate_limiting_wait_in_seconds

          super(
            adaptor: adaptor,
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
