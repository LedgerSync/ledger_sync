# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      class LedgerSerializer < Adaptors::LedgerSerializer
        def self.ledger_serializer_for(resource_class:)
          NetSuite.const_get("#{resource_class.name.split('LedgerSync::')[1..-1].join('LedgerSync::')}::LedgerSerializer")
        end

        # This is used to map our internal resources to the netsuite gem
        # resource
        def self.netsuite_lib_class(lib_class)
          @netsuite_lib_class ||= lib_class
        end
      end
    end
  end
end
