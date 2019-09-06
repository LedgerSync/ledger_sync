module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              schema do
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
              op = if qbo_expense?
                     Update.new(adaptor: adaptor, resource: resource)
                   else
                     Create.new(adaptor: adaptor, resource: resource)
                   end

              build_vendor_operation
              add_root_operation(op)
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
