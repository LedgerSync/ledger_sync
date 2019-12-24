# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Vendor
        module Operations
          class Valid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                optional(:external_id).maybe(:string)
                optional(:ledger_id).maybe(:string)
                optional(:display_name).maybe(:string)
                optional(:first_name).maybe(:string)
                optional(:last_name).maybe(:string)
                optional(:email).maybe(:string)
                optional(:company_name).maybe(:string)
                optional(:phone_number).maybe(:string)
                optional(:subsidiary).maybe(:hash, Types::Reference)
              end
            end

            private

            def operate
              success(response: :foo)
            end
          end
        end
      end
    end
  end
end
