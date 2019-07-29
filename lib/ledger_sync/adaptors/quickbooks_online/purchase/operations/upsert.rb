module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Purchase
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).maybe(:string)
                required(:amount).filled(:integer)
                required(:currency).filled(:string)
                required(:vendor).hash(Types::Reference)
              end
            end

            private

            def build
              op = if qbo_purchase?
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

            def qbo_purchase?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
