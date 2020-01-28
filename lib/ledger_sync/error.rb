# frozen_string_literal: true

module LedgerSync
  class Error < StandardError
    attr_reader :message

    def initialize(message:)
      @message = message
      super(message)
    end

    class UnexpectedClassError < self
      def initialize(expected:, given:)
        expected = [expected] unless expected.is_a?(Array)

        super(
          message: "Unexpected class.  Given #{given.name}.  Expected: #{expected.map(&:name).join(', ')}"
        )
      end
    end
  end
end
