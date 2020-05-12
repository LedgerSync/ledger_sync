# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Util
        class ErrorMatcher
          attr_reader :error,
                      :message

          def initialize(error:)
            @error = error
            @message = error.message.to_s
          end

          def body
            error.response.body
          rescue NoMethodError
            nil
          end

          def error_class
            raise NotImplementedError
          end

          def error_message
            (body && JSON.parse(body).dig('fault', 'error')&.first&.fetch('message')) ||
            (body && JSON.parse(body).dig('Fault', 'Error')&.first&.fetch('Message')) ||
              (body && JSON.parse(body).dig('error')) ||
              error.message
          end

          def detail
            (body && JSON.parse(body).dig('fault', 'error')&.first&.fetch('detail')) ||
            (body && JSON.parse(body).dig('Fault', 'Error')&.first&.fetch('Detail'))
          end

          def code
            ((body && JSON.parse(body).dig('fault', 'error')&.first&.fetch('code')) ||
            (body && JSON.parse(body).dig('Fault', 'Error')&.first&.fetch('code'))).to_i
          end

          def match?
            raise NotImplementedError
          end

          def output_message
            raise NotImplementedError
          end
        end
      end
    end
  end
end
