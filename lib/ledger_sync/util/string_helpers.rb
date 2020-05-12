# frozen_string_literal: true

module LedgerSync
  module Util
    module StringHelpers
      module_function

      def camelcase(str)
        str.to_s.split('/').map { |e| inflect(e.split('_').collect(&:camelcase).join) }.join('::')
      end

      def underscore!(str)
        str.gsub!(/::/, '/')
        str.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        str.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        str.tr!('-', '_')
        str.downcase!
      end

      def underscore(str)
        str.dup.tap(&method(:underscore!))
      end

      def inflect(str)
        return str unless LedgerSync.respond_to?(:ledgers)

        LedgerSync.ledgers.inflections.each do |inflection|
          next unless inflection.downcase == str.downcase

          return inflection
        end

        str
      end
    end
  end
end
