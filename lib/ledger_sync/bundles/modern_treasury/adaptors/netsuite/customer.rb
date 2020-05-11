# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module NetSuite
          class Customer
            attr_reader :resource

            delegate  :external_id,
                      :external_id=,
                      :ledger_id,
                      :ledger_id=,
                      to: :resource

            def initialize(args = {})
              @resource = args.fetch(:resource).dup
            end

            def email
              resource.email
            end

            def email=(val)
              resource.email = val
            end

            def companyName
              resource.name
            end

            def companyName=(val)
              resource.name = val
            end

            def firstName
              resource.first_name
            end

            def firstName=(val)
              resource.first_name = val
            end

            def lastName
              resource.last_name
            end

            def lastName=(val)
              resource.last_name = val
            end

            def phone
              resource.phone_numer
            end

            def phone=(val)
              resource.phone_numer = val
            end


            # def self.attribute(record_attribute, args = {}, &block)
            #   resource_attribute = args.fetch(:resource_attribute, nil)

            #   raise 'resource_attribute required if a block is not provided.'

            #   attributes[record_attribute.to_sym] = {
            #     block: block,
            #     record_attribute: record_attribute,
            #     resource_attribute: resource_attribute
            #   }

            #   define_method("#{record_attribute}") do
            #     if block.present?
            #       block.call
            #     else
            #       resource_attribute
            #     end
            #   end
            # end

            # def self.attributes
            #   @attributes ||= {}
            # end
          end
        end
      end
    end
  end
end
