module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).maybe(:string)
                required(:first_name).filled(:string)
                required(:last_name).filled(:string)
                optional(:email).maybe(:string)
              end
            end

            private

            def build
              op =  if vendor_exists_in_ledger?
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

            def vendor_exists_in_ledger?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
