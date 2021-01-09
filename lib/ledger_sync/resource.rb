# frozen_string_literal: true

require_relative 'resource_attribute'

# Template class for named resources such as
# LedgerSync::Invoice, LedgerSync::Contact, etc.
module LedgerSync
  class Resource
    include SimplySerializable::Mixin
    include Validatable
    include Fingerprintable::Mixin
    include ResourceAttribute::Mixin
    include ResourceAttribute::Reference::One::Mixin
    include ResourceAttribute::Reference::Many::Mixin
    include Util::Mixins::DupableMixin
    include Ledgers::Mixins::InferConfigMixin

    PRIMITIVES = [
      ActiveModel::Type,
      Date,
      DateTime,
      FalseClass,
      Float,
      Integer,
      NilClass,
      String,
      Time,
      TrueClass
    ].freeze

    simply_serialize except: %i[resource_attributes references]

    attribute :external_id, type: Type::ID
    attribute :ledger_id, type: Type::ID

    def assign_attribute(name, value)
      public_send("#{name}=", value)
      self
    end

    def assign_attributes(keywords)
      keywords.each { |k, v| assign_attribute(k, v) }
      self
    end

    def changed?
      super || resource_attributes.references_many.select(&:changed?).any?
    end

    def changes
      super.merge(Hash[resource_attributes.references_many.map do |ref|
                         [ref.name, ref.changes['value']] if ref.changed?
                       end.compact])
    end

    def class_from_resource_type(obj)
      LedgerSync.const_get(LedgerSync::Util::StringHelpers.camelcase(obj))
    end

    def to_h
      resource_attributes.to_h.merge(dirty_attributes_to_h)
    end

    def self.inherited(subclass)
      resource_attributes.each do |_name, resource_attribute|
        subclass._add_resource_attribute(resource_attribute)
      end

      LedgerSync.register_resource(resource: subclass)

      return if subclass.inferred_config.nil?

      subclass.inferred_config.client_class.register_resource(resource: subclass)

      super
    end

    def self.operations
      @operations ||= {}
    end

    def self.resource_module_str
      @resource_module_str ||= name.split('::').last
    end

    def self.resource_type
      @resource_type ||= LedgerSync::Util::StringHelpers.underscore(name.split('::').last).to_sym
    end

    def self.serialize_attribute?(sattr)
      sattr = sattr.to_sym
      return true if resource_attributes.key?(sattr)

      false
    end

    def ==(other)
      other&.fingerprint == fingerprint
    end
  end
end
