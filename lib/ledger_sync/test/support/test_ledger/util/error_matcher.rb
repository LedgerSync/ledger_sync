# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
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

          def error_message # rubocop:disable Metrics/CyclomaticComplexity
            return error.message unless body

            parsed_body = JSON.parse(body)

            parsed_body.dig('fault', 'error')&.first&.fetch('message') ||
              parsed_body.dig('Fault', 'Error')&.first&.fetch('Message') ||
              parsed_body['error']
          end

          def detail # rubocop:disable Metrics/CyclomaticComplexity
            (body && JSON.parse(body).dig('fault', 'error')&.first&.fetch('detail')) ||
              (body && JSON.parse(body).dig('Fault', 'Error')&.first&.fetch('Detail'))
          end

          def code # rubocop:disable Metrics/CyclomaticComplexity
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
