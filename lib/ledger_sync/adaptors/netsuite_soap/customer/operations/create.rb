module LedgerSync
  module Adaptors
    module NetSuiteSOAP
      module Customer
        module Operations
          class Create < NetSuiteSOAP::Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
                required(:subsidiary).hash(Types::Reference)
              end
            end

            private

            def operate
              netsuite_subsidiary = ::NetSuite::Records::Subsidiary.get(
                internal_id: resource.subsidiary.ledger_id
              )

              unless netsuite_subsidiary
                return failure(
                  error: Error::OperationError.new(
                    message: "Subsidiary with ID '#{resource.subsidiary.ledger_id}' does not exist.",
                    operation: self
                  )
                )
              end

              netsuite_resource = ::NetSuite::Records::Customer.new(
                company_name: resource.name,
                email: resource.email,
                external_id: resource.external_id,
                entity_id: resource.external_id,
                first_name: resource.first_name,
                last_name: resource.last_name,
                phone: resource.phone_number,
                subsidiary: netsuite_subsidiary
              )

              return netsuite_failure(netsuite_resource: netsuite_resource) unless netsuite_resource.add

              resource.email = netsuite_resource.email
              resource.external_id = netsuite_resource.external_id
              resource.name = "#{netsuite_resource.first_name} #{netsuite_resource.last_name}"
              resource.phone_number = netsuite_resource.phone

              resource.ledger_id = netsuite_resource.internal_id

              success(
                resource: resource,
                response: netsuite_resource
              )
            end
          end
        end
      end
    end
  end
end
