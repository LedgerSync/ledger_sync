# frozen_string_literal: true

require_relative 'webhook_event'

# ref: https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification
module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class WebhookNotification
        attr_reader :events,
                    :original_payload,
                    :payload,
                    :realm_id,
                    :webhook

        def initialize(payload:, webhook: nil)
          @original_payload = payload
          payload = JSON.parse(payload) if payload.is_a?(String)
          @payload = payload

          @realm_id = payload.dig('realmId')
          raise 'Invalid payload: Could not find realmId' if @realm_id.blank?

          events_payload = payload.dig('dataChangeEvent', 'entities')
          raise 'Invalid payload: Could not find dataChangeEvent -> entities' if events_payload.blank?

          @events = []

          events_payload.each do |event_payload|
            @events << WebhookEvent.new(
              payload: event_payload,
              webhook_notification: self
            )
          end
        end

        def resources
          @resources ||= events.map(&:resource)
        end
      end
    end
  end
end
