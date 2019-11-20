# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        module Operations
          class Find < NetSuite::Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                required(:email).maybe(:string)
                required(:name).maybe(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              customer = ::NetSuite::Records::Customer.get(
                internal_id: resource.ledger_id
              )

              resource.email = customer.email
              resource.external_id = customer.external_id
              resource.external_id = customer.internal_id
              resource.name = if customer.is_person
                                "#{customer.first_name} #{customer.last_name}"
                              else
                                customer.company_name
                              end
              resource.phone_number = customer.phone

              resource.ledger_id = customer.internal_id

              success(
                resource: resource,
                response: customer
              )
            end
          end
        end
      end
    end
  end
end
