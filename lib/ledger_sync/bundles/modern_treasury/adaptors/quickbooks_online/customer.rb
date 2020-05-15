# frozen_string_literal: true

require_relative 'primary_email_addr'
require_relative 'primary_phone'

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module QuickBooksOnline
          class Customer < ResourceAdaptor
            references_one :PrimaryEmailAddr, adaptor_class: PrimaryEmailAddr
            references_one :PrimaryPhone, adaptor_class: PrimaryPhone

            def DisplayName
              [
                resource.first_name,
                resource.last_name
              ].compact.join(' ')
            end

            def DisplayName=(val)
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
