module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).maybe(:string)
                optional(:email).maybe(:string)
                required(:name).filled(:string)
                optional(:phone_number).maybe(:string)
              end
            end

            private

            def build
              op =  if customer_exists_in_ledger?
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

            def customer_exists_in_ledger?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
