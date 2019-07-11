# frozen_string_literal: true

module LedgerSync
  class Error
    class OperationError < Error
      attr_reader :operation

      def initialize(message:, operation:)
        @operation = operation
        super(message: message)
      end

      class DuplicateLedgerResourceError < self; end
      class NotFoundError < self; end
      class LedgerValidationError < self; end

      class PerformedOperationError < self
        def initialize(message: nil, operation:)
          message ||= 'Operation has already been performed. Please check the result.'

          super(message: message, operation: operation)
        end
      end

      class ValidationError < self
        attr_reader :attribute,
                    :validation

        def initialize(message:, attribute:, operation:, validation:)
          @attribute = attribute
          @validation = validation

          super(
            message: message,
            operation: operation
          )
        end
      end
    end
  end
end
