# frozen_string_literal: true

# ref: https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification
module LedgerSync
  module Ledgers
    module TestLedger
      class WebhookEvent
        attr_reader :deleted_id,
                    :event_operation,
                    :last_updated_at,
                    :ledger_id,
                    :original_payload,
                    :payload,
                    :test_ledger_resource_type,
                    :webhook_notification,
                    :webhook

        def initialize(payload:, webhook_notification: nil)
          @original_payload = payload
          @payload = payload.is_a?(String) ? JSON.parse(payload) : payload

          @deleted_id = @payload['deletedId']

          @event_operation = @payload['operation']
          raise 'Invalid payload: Could not find operation' if @event_operation.blank?

          @last_updated_at = @payload['lastUpdated']
          raise 'Invalid payload: Could not find lastUpdated' if @last_updated_at.blank?

          @last_updated_at = Time.parse(@last_updated_at)

          @ledger_id = @payload['id']
          raise 'Invalid payload: Could not find id' if @ledger_id.blank?

          @test_ledger_resource_type = @payload['name']
          raise 'Invalid payload: Could not find name' if @test_ledger_resource_type.blank?

          @webhook_notification = webhook_notification
          @webhook = webhook_notification.try(:webhook)
        end

        def find(client:)
          find_operation(client: client).perform
        end

        def find_operation(client:)
          find_operation_class(client: client).new(
            client: client,
            resource: resource_class.new(ledger_id: ledger_id)
          )
        end

        def find_operation_class(client:)
          client.class.base_operations_module_for(resource_class: resource_class)::Find
        end

        def local_resource_type
          @local_resource_type ||= resource_class.resource_type
        end

        def resource
          return unless resource_class.present?

          resource_class.new(ledger_id: ledger_id)
        end

        def resource!
          if resource.nil?
            raise "Resource class does not exist for QuickBooks Online object: #{test_ledger_resource_type}"
          end

          resource
        end

        def resource_class
          @resource_class ||= Client.resource_from_ledger_type(type: test_ledger_resource_type.downcase)
        end
      end
    end
  end
end
