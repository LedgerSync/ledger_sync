# frozen_string_literal: true

module LedgerSync
  class Error
    class AdaptorError < Error
      attr_reader :adaptor

      def initialize(adaptor:, message:)
        @adaptor = adaptor
        super(message: message)
      end

      class MissingAdaptorError < self
        def initialize(message:)
          super(message: message, adaptor: nil)
        end
      end

      class AdaptorValidationError < self
        attr_reader :attribute, :validation

        def initialize(message:, adaptor:, attribute:, validation:)
          @attribute = attribute
          @validation = validation
          super(message: message, adaptor: adaptor)
        end
      end

      class ThrottleError < self
        attr_reader :rate_limiting_wait_in_seconds

        def initialize(adaptor:, message: nil)
          message ||= 'Your request has been throttled.'
          @rate_limiting_wait_in_seconds = LedgerSync.adaptors.config_from_klass(
            klass: adaptor.class
          ).rate_limiting_wait_in_seconds

          super(adaptor: adaptor, message: message)
        end
      end

      class AuthenticationError < self; end
      class AuthorizationError < self; end
      class ConfigurationError < self; end
    end
  end
end
