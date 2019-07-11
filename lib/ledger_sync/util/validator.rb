module LedgerSync
  module Util
    class Validator
      attr_reader :data,
                  :contract

      def initialize(contract:, data:)
        @data = data
        @contract = contract
      end

      def errors
        @errors ||= call_contract.errors
      end

      def full_messages
        @full_messages ||= errors.messages.map { |e| "#{e.path.map(&:to_s).join(' ')} #{e.text}"}
      end

      def message
        @message ||= full_messages.first
      end

      def valid?
        call_contract.success?
      end

      def validate
        return success if valid?

        failure
      end

      private

      def call_contract
        @call_contract ||= contract.new.call(data)
      end

      def failure
        ValidationResult.Failure(validator: self)
      end

      def success
        ValidationResult.Success(validator: self)
      end
    end
  end
end
