# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Stripe
      class Customer
        module Operations
          class Create < Stripe::Operation::Create
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
                required(:email).maybe(:string)
                required(:name).filled(:string)
                required(:phone_number).maybe(:string)
                optional(:subsidiary).maybe(:hash, Types::Reference)
              end
            end

            private

            def operate
              stripe_customer = ::Stripe::Customer.create(
                email: resource.email,
                metadata: {
                  external_id: resource.external_id
                },
                name: resource.name,
                phone: resource.phone_number
              )

              resource.ledger_id = stripe_customer.id

              success(
                resource: resource,
                response: stripe_customer
              )
            end
          end
        end
      end
    end
  end
end
