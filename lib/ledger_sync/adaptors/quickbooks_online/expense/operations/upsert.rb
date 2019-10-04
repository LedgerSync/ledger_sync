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

            def build
              op = if find_result.success?
                Update.new(adaptor: adaptor, resource: resource)
              else
                Create.new(adaptor: adaptor, resource: resource)
              end
              op.build

              op.before_operations.each {|o| add_before_operation(o)}
              op.after_operations.each {|o| add_after_operation(o)}
              add_root_operation(op.root_operation)
            end

            private

            def find_result
              @find_result ||= Find.new(
                adaptor: adaptor,
                resource: resource
              ).perform
            end
          end
        end
      end
    end
  end
end
