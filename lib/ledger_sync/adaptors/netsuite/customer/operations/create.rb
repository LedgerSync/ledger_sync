module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        module Operations
          class Create < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              customer = ::NetSuite::Records::Customer.new(
                email: resource.email,
                external_id: resource.external_id,
                first_name: resource.first_name,
                last_name: resource.last_name,
                phone: resource.phone_number
              )

              customer.add

              resource.email = customer.email
              resource.external_id = customer.external_id
              resource.external_id = customer.internal_id
              resource.name = "#{customer.first_name} #{customer.last_name}"
              resource.phone_number = customer.phone

              resource.ledger_id = customer.internal_id

              success(
                resource: resource
              )
            end
          end
        end
      end
    end
  end
end
