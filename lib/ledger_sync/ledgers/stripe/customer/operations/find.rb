# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Stripe
      module Customer
        module Operations
          class Find < Stripe::Operation::Find
            class Contract < LedgerSync::Ledgers::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).filled(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
                optional(:subsidiary).maybe(:hash, Types::Reference)
              end
            end

            private

            def operate
              stripe_customer = ::Stripe::Customer.retrieve(
                resource.ledger_id
              )

              resource.external_id = stripe_customer.metadata['external_id']
              resource.email = stripe_customer.email
              resource.name = stripe_customer.name
              resource.phone_number = stripe_customer.phone

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
