# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:account).hash(Types::Reference)
                required(:vendor).hash(Types::Reference)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
                required(:reference_number).filled(:string)
              end
            end

            private

            def operate
              response = adaptor.post(
                resource: 'purchase',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('id')
              success(
                resource: Test::LedgerSerializer.new(resource: resource).deserialize(hash: response),
                response: response
              )
            end

            def local_resource_data
              {
                'currency' => resource.currency,
                'account_id' => resource.account.ledger_id,
                'vendor_id' => resource.vendor.ledger_id,
                'line_items' => resource.line_items.map do |line_item|
                  {
                    'account_id' => line_item.account&.ledger_id,
                    'Amount' => line_item.amount / 100.0,
                    'description' => line_item.description
                  }
                end
              }
            end
          end
        end
      end
    end
  end
end
