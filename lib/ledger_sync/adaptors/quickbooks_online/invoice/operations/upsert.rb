module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Invoice
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).maybe(:string)
                required(:currency).maybe(:string)
                required(:customer).maybe(Types::Reference)
                required(:line_items).maybe(:array)
                required(:number).maybe(:integer)
              end
            end

            private

            def build
              op =  if qbo_invoice?
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

            def qbo_invoice?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
