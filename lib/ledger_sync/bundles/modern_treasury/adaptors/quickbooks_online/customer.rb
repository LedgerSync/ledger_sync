# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module QuickBooksOnline
          class Customer < ResourceAdaptor
            attribute :email
            attribute :phone, resource_attribute: :phone_number

            def name
              [
                resource.first_name,
                resource.last_name
              ].compact.join(' ')
            end

            def name=(val)
              if val.nil?
                resource.first_name = nil
                resource.last_name = nil
                return
              end

              vals = val.split(' ')
              resource.first_name = vals.shift
              resource.last_name = vals.join(' ')

              name
            end
          end
        end
      end
    end
  end
end
