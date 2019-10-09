# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        TYPES = %i[create find update upsert].freeze

        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
          end

          def perform
            super
          rescue OAuth2::Error => e
            failure(e)
          end
        end

        TYPES.each do |type|
          klass = Class.new do
            include QuickBooksOnline::Operation::Mixin
          end
          Operation.const_set(LedgerSync::Util::StringHelpers.camelcase(type.to_s), klass)
        end
      end
    end
  end
end
