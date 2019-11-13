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

    serialize except: %i[resource_attributes references]

    def assign_attribute(name, value)
      public_send("#{name}=", value)
    end

    def assign_attributes(**keywords)
      keywords.each { |k, v| assign_attribute(k, v) }
    end

    def changed?
      super || resource_attributes.references_many.select(&:changed?).any?
    end

    def changes
      super.merge(Hash[resource_attributes.references_many.map { |ref| [ref.name, ref.changes['value']] if ref.changed? }.compact])
    end

    def dup
      Marshal.load(Marshal.dump(self))
    end

    def klass_from_resource_type(obj)
      LedgerSync.const_get(LedgerSync::Util::StringHelpers.camelcase(obj))
    end

    def to_h
      resource_attributes.to_h.merge(dirty_attributes_to_h)
    end

    def self.inherited(subclass)
      subclass.attribute :external_id, type: Type::ID
      subclass.attribute :ledger_id, type: Type::ID
    end

    def self.resource_module_str
      @resource_module_str ||= name.split('LedgerSync::')[1..-1].join('LedgerSync::')
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
      other.fingerprint == fingerprint
    end
  end
end
