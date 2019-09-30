module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
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
              ledger_resource_data = adaptor.find(
                resource: 'purchase',
                id: resource.ledger_id
              )
              response = adaptor.upsert(
                resource: 'purchase',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
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
              vendor = Vendor::Operations::Upsert.new(
                adaptor: adaptor,
                resource: resource.vendor
              )

              add_before_operation(vendor)
            end

            def local_resource_data
              {
                'CurrencyRef' => {
                  'value' => resource.currency,
                },
                'PaymentType' => Mapping::PAYMENT_TYPES[resource.payment_type],
                'TxnDate' => resource.transaction_date.to_s, # Format: YYYY-MM-DD
                'PrivateNote' => resource.memo,
                'ExchangeRate' => resource.exchange_rate,
                'EntityRef' => {
                  'value' => resource.vendor.ledger_id,
                },
                'AccountRef' => {
                  'value' => resource.account.ledger_id
                },
                'Line' => resource.line_items.map do |line_item|
                  {
                    'DetailType' => 'AccountBasedExpenseLineDetail',
                    'AccountBasedExpenseLineDetail' => {
                      'AccountRef' => {
                        'value' => line_item.account&.ledger_id || resource.account.ledger_id
                      }
                    },
                    'Amount' => line_item.amount / 100.0,
                    'Description' => line_item.description
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
