# frozen_string_literal: true

require_relative 'webhook_event'

# ref: https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification
module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Webhook
        attr_reader :notifications,
                    :original_payload,
                    :payload

        def initialize(payload:)
          @original_payload = payload
          @payload = payload.is_a?(String) ? JSON.parse(payload) : payload

          event_notifications_payload = @payload.dig('eventNotifications')
          raise 'Invalid payload: Could not find eventNotifications' unless event_notifications_payload.is_a?(Array)

          @notifications = []

          event_notifications_payload.each do |event_notification_payload|
            @notifications << WebhookNotification.new(
              payload: event_notification_payload,
              webhook: self
            )
          end
        end

        def events
          notifications.map(&:events)
        end

        def resources
          @resources ||= notifications.map(&:resources).flatten.compact
        end

        def valid?(signature:, verification_token:)
          self.class.valid?(
            payload: payload.to_json,
            signature: signature,
            verification_token: verification_token
          )
        end

        def self.valid?(payload:, signature:, verification_token:)
          raise 'Cannot verify non-String payload' unless payload.is_a?(String)

          digest = OpenSSL::Digest.new('sha256')
          hmac = OpenSSL::HMAC.digest(digest, verification_token, payload)
          base64 = Base64.encode64(hmac).strip
          base64 == signature
        end
      end
    end
  end
end
