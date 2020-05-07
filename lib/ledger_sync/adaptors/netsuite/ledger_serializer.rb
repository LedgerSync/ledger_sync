# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'
Gem.find_files('ledger_sync/adaptors/netsuite/ledger_serializer_type/**/*.rb').each { |path| require path } # require adaptor-specific types

module LedgerSync
  module Adaptors
    module NetSuite
      class LedgerSerializer < Adaptors::LedgerSerializer
        def self.api_resource_path(resource: nil)
          raise 'Resource ledger_id is required to build API request path' if resource.present? && resource.ledger_id.blank?

          ret = api_resource_type.to_s
          ret += "/#{resource.ledger_id}" if resource.present?
          ret
        end

        def self.api_resource_type(val = nil)
          raise 'api_resource_type already set' if @api_resource_type.present? && val.present?

          @api_resource_type ||= val
        end

        def self.id(**keywords)
          super(**{ ledger_attribute: 'id', resource_attribute: :ledger_id }.merge(keywords))
        end
      end
    end
  end
end
