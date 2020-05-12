# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      module Customer
        module Operations
          class Find < NetSuiteSOAP::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                optional(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
                required(:subsidiary).maybe(:hash, Types::Reference)
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
