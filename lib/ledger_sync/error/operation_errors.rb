# frozen_string_literal: true

module LedgerSync
  class Error
    class OperationError < Error
      attr_reader :operation, :response

      def initialize(message: nil, operation:, response: nil)
        message ||= 'Operation failed.'
        @operation = operation
        @response = response
        super(message: message)
      end

      class DuplicateLedgerResourceError < self; end
      class NotFoundError < self; end
      class LedgerValidationError < self; end
      class LedgerIDRequired < self
        def initialize(**keywords)
          super(
            {
              message: 'Resource ledger_id is required.'
            }.merge(keywords)
          )
        end
      end

      class PerformedOperationError < self
        def initialize(message: nil, operation:, response: nil)
          message ||= 'Operation has already been performed. Please check the result.'

          super(
            message: message,
            operation: operation,
            response: response
          )
        end
      end

      class ValidationError < self
        attr_reader :attribute,
                    :validation

        def initialize(message:, attribute:, operation:, validation:, response:nil)
          @attribute = attribute
          @validation = validation

          super(
            message: message,
            operation: operation,
            response: response
          )
        end
      end
    end
  end
end
