# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Util
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
            return error.message unless body

            parsed_body = JSON.parse(body)

            parsed_body.dig('fault', 'error')&.first&.fetch('message') ||
              parsed_body.dig('Fault', 'Error')&.first&.fetch('Message') ||
              parsed_body.dig('error')
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
