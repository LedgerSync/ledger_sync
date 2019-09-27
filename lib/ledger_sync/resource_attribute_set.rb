# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeSet
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def types
      @types ||= self.class.types
    end

    def valid?
      return true if value.nil?
      return true if valid_classes.select { |e| value.is_a?(e) }.any?

      false
    end

    def valid_classes
      types[type]
    end

    def self.types
      @types ||= TYPES
    end
  end
end
