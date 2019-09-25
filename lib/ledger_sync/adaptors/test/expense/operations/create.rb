module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).value(:nil)
                required(:account).hash(Types::Reference)
                required(:vendor).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:date?)
                required(:exchange_rate).maybe(:float)
                required(:line_items).array(Types::Reference)
              end
            end

            private

            def build
              build_account_operation(resource.account)
              resource.line_items.each do |line_item|
                build_account_operation(line_item.account)
              end
              build_vendor_operation
              add_root_operation(self)
            end

            def operate
              response = adaptor.upsert(
                resource: 'purchase',
                payload: local_resource_data
              )

              resource.ledger_id = response.dig('id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def build_account_operation(account)
              account_op = Account::Operations::Upsert.new(
                adaptor: adaptor,
                resource: account
              )

              add_before_operation(account_op)
            end

            def build_vendor_operation
              vendor_op = Vendor::Operations::Upsert.new(
                adaptor: adaptor,
                resource: resource.vendor
              )

              add_before_operation(vendor_op)
            end

            def local_resource_data
              {
                'amount' => resource.amount,
                'currency' => resource.currency,
                'account_id' => resource.account.ledger_id,
                'vendor_id' => resource.vendor.ledger_id,
                'line_items' => resource.line_items.map do |line_item|
                  {
                    'account_id' => line_item.account&.ledger_id || resource.account.ledger_id,
                    'amount' => line_item.amount,
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
