# frozen_string_literal: true

require_relative 'error_matcher'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Util
        class ErrorParser
          attr_reader :error

          def initialize(error:)
            @error = error
          end

          def error_class
            raise NotImplementedError
          end

          def parse
            raise NotImplementedError
          end
        end
      end
    end
  end
end
