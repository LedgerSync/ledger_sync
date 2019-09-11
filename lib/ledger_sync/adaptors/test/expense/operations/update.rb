module LedgerSync
  module Adaptors
    module Test
      module Expense
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:vendor).hash(Types::Reference)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:memo).filled(:string)
                required(:payment_type).filled(:string)
                required(:transaction_date).filled(:string)
                required(:transactions).array(:hash) do
                  required(:amount).filled(:integer)
                  required(:description).maybe(:string)
                end
              end
            end

            private

            def build
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

              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
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
                'amount': resource.amount,
                'currency': resource.currency,
                'vendor_id': resource.vendor.ledger_id
              }
            end
          end
        end
      end
    end
  end
end
