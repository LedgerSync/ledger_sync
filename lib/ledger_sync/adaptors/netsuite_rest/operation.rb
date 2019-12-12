# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def ledger_deserializer
              @ledger_deserializer ||= begin
                modules = self.class.name.split('::Operations::').first
                Object.const_get("#{modules}::LedgerDeserializer").new(resource: resource)
              end
            end
          end
        end
      end
    end
  end
end
