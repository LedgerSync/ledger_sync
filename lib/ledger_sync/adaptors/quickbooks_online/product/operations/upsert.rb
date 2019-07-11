module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Product
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).maybe(:string)
                required(:ledger_id).maybe(:string)
                optional(:description).maybe(:string)
                required(:name).filled(:string)
              end
            end

            private

            def build
              op =  if qbo_item?
                      Update.new(adaptor: adaptor, resource: resource)
                    else
                      Create.new(adaptor: adaptor, resource: resource)
                    end

              add_root_operation(op)
            end

            def find_result
              @find_result ||= Find.new(
                adaptor: adaptor,
                resource: resource
              ).perform
            end

            def qbo_item?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
