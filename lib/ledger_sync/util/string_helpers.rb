module LedgerSync
  module Util
    module StringHelpers
      extend self

      def camelcase(str)
        str.to_s.split('/').map { |e| e.split('_').collect(&:capitalize).map(&method(:inflect)).join }.join('::')
      end

      # def underscore!(str)
      #   str.gsub!(/(.)([A-Z])/, '\1_\2')
      #   str.downcase!
      # end

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
        case str.downcase
        when 'quickbooks'
          'QuickBooks'
        else
          str
        end
      end
    end
  end
end
