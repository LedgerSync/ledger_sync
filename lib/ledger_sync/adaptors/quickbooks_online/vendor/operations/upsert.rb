# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Vendor
        module Operations
          class Upsert < Operation::Upsert
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                optional(:ledger_id).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
              end
            end

            private

            def build
              op = if qbo_vendor?
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

            def qbo_vendor?
              find_result.success?
            end
          end
        end
      end
    end
  end
end
