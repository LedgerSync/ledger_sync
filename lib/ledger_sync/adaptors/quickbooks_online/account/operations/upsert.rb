module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              params do
                optional(:ledger_id).maybe(:string)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
              end
            end

            private

            def build
              op =  if qbo_account?
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

            def qbo_account?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
