# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeSet
    attr_reader :attributes,
                :references,
                :references_one,
                :references_many,
                :resource

    delegate  :[],
              :key?,
              :keys,
              :include?,
              to: :attributes

    alias names keys

    def initialize(resource:)
      @attributes = {}
      @references = []
      @references_one = []
      @references_many = []

      @resource = resource
    end

    def add(attribute)
      name = attribute.name
      raise "Attribute #{name} already exists on #{resource.name}." if attributes.key?(name)

      case attribute
      when ResourceAttribute
        nil
      when ResourceAttribute::Reference::One
        @references << attribute
        @references_one << attribute
      when ResourceAttribute::Reference::Many
        @references << attribute
        @references_many << attribute
      else
        raise 'Unknown attribute class'
      end

      @attributes[attribute.name] = attribute
    end

    def to_h
      Hash[attributes.map { |k, v| [k, v.value] }]
    end
  end
end
