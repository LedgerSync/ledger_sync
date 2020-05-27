---
title: Webhooks
layout: reference_quickbooks_online
ledger: quickbooks_online
---

Reference: [QuickBooks Online Webhook Documentation](https://developer.intuit.com/app/developer/qbo/docs/develop/webhooks/managing-webhooks-notifications#validating-the-notification)

LedgerSync offers an easy way to validate and parse webhook payloads.  It also allows you to easily fetch the resources referenced.  You can create and use a webhook with the following:

```ruby
# Assuming `request` is the webhook request received from Quickbooks Online
webhook = LedgerSync::Ledgers::QuickBooksOnline::Webhook.new(
  payload: request.body.read # It accepts a JSON string or hash
)

verification_token = WEBHOOK_VERIFICATION_TOKEN # You get this token when you create webhooks in the QuickBooks Online dashboard
signature = request.headers['intuit-signature']
raise 'Not valid' unless webhook.valid?(signature: signature, verification_token: verification_token)

# Although not yet used, webhooks may include notifications for multiple realms
webhook.notifications.each do |notification|
  puts notification.realm_id

  # Multiple events may be referenced.
  notification.events.each do |event|
    puts event.resource # Returns a LedgerSync resource with the `ledger_id` set

    # Other helpful methods
    notification.find_operation_class(client: your_quickbooks_client_instance) # The respective Find class
    notification.find_operation(client: your_quickbooks_client_instance) # The initialized respective Find operation
    notification.find(client: your_quickbooks_client_instance) # Performs a Find operation for the resource retrieving the latest version from QuickBooks Online
  end

  # Other helpful methods
  notification.resources # All resources for a given webhook across all events
end

# Other helpful methods
webhook.events # All events for a given webhook across all realms
webhook.resources # All events for a given webhook across all realms and events
```