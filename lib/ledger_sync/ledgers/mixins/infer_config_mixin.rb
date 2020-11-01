# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferConfigMixin
        module ClassMethods
          def inferred_config
            @inferred_config ||= begin
              return if name.nil?

              name_parts = name.split('::')
              name_parts_length = name_parts.count

              config = nil

              name_parts_length.times do |i|
                config = LedgerSync.ledgers.config_from_base_module(
                  base_module: Object.const_get(
                    name_parts[0..(name_parts_length - 1 - i)].join('::')
                  )
                )
                break if config.present?
              end

              config
            end
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
