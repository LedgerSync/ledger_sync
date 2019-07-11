module LedgerSync
  module Adaptors
    module Test
      module Payment
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).maybe(:string)
                required(:amount).value(:integer)
                required(:currency).value(:string)
                required(:customer).value(Types::Reference)
              end
            end

            private

            def build
              op =  if qbo_payment?
                      Update.new(adaptor: adaptor, resource: resource)
                    else
                      Create.new(adaptor: adaptor, resource: resource)
                    end

              build_customer_operation
              add_root_operation(op)
            end

            def build_customer_operation
              customer = Customer::Operations::Upsert.new(
                adaptor: adaptor,
                resource: resource.customer
              )

              add_before_operation(customer)
            end

            def find_result
              @find_result ||= Find.new(
                adaptor: adaptor,
                resource: resource
              ).perform
            end

            def qbo_payment?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
