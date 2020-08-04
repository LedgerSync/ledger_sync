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
            @body ||= error.response.body
          rescue NoMethodError
            nil
          end

          def error_class
            raise NotImplementedError
          end

          def error_message
            return error.message unless body

            fault&.fetch('message') ||
              fault&.fetch('Message') ||
              parsed_body.dig('error')
          end

          def detail
            return if body.blank?

            fault&.fetch('detail') ||
              fault&.fetch('Detail')
          end

          def code
            return if body.blank?

            fault&.fetch('code') ||
              fault&.fetch('code').to_i
          end

          def match?
            raise NotImplementedError
          end

          def parsed_body
            @parsed_body ||= JSON.parse(body)
          end

          def output_message
            raise NotImplementedError
          end

          private

          def fault
            parsed_body.dig('fault', 'error')&.first ||
              parsed_body.dig('Fault', 'Error')&.first
          end
        end
      end
    end
  end
end
