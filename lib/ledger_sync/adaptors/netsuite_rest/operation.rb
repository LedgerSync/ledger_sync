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
          end
        end
      end
    end
  end
end
