# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeCollection
    attr_reader :attributes,
                :custom_attributes,
                :references,
                :references_one,
                :references_many,
                :resource

    delegate  :[],
              :each,
              :include?,
              :key?,
              :keys,
              :map,
              to: :attributes

    alias names keys

    def initialize(resource:)
      @attributes = {}
      @custom_attributes = {}
      @references = []
      @references_one = []
      @references_many = []

      @resource = resource
    end

    def add(attribute)
      raise Error::UnexpectedClassError.new(expected: ResourceAttribute, given: attribute.class) unless attribute.is_a?(ResourceAttribute)

      name = attribute.name
      raise "Attribute #{name} already exists on #{resource.name}." if attributes.key?(name)

      @attributes[attribute.name] = attribute

      if attribute.references_one?
        @references << attribute
        @references_one << attribute
      elsif attribute.references_many?
        @references << attribute
        @references_many << attribute
      elsif attribute.custom?
        @custom_attributes << attribute
      end
    end

    def to_a
      attributes.values
    end

    def to_h
      Hash[attributes.map { |k, v| [k, v.value] }]
    end
  end
end
