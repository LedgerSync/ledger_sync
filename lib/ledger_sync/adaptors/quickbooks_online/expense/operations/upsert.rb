module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Upsert < Operation::Upsert
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
              op = if qbo_expense?
                     Update.new(adaptor: adaptor, resource: resource)
                   else
                     Create.new(adaptor: adaptor, resource: resource)
                   end

              build_account_operation(resource.account)
              resource.line_items.each do |line_item|
                build_account_operation(line_item.account)
              end
              build_vendor_operation
              add_root_operation(op)
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

            def find_result
              @find_result ||= Find.new(
                adaptor: adaptor,
                resource: resource
              ).perform
            end

            def qbo_expense?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
