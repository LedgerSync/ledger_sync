# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:display_name).maybe(:string)
                required(:first_name).maybe(:string)
                required(:last_name).maybe(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'vendor',
                id: resource.ledger_id
              )

              success(response: response)
            end
          end
        end
      end
    end
  end
end
