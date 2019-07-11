# frozen_string_literal: true

# Template class for named resources such as
# LedgerSync::Invoice, LedgerSync::Contact, etc.
module LedgerSync
  class Resource
    include SimplySerializable::Mixin
    include Validatable
    include Fingerprintable::Mixin

    # serialize only: %i[
    #   attributes
    #   external_id
    #   ledger_id
    #   sync_token
    # ]

    attr_accessor :external_id, :ledger_id, :sync_token

    def initialize(external_id: nil, ledger_id: nil, sync_token: nil, **data)
      @external_id = external_id.to_s.to_sym
      @ledger_id = ledger_id
      @sync_token = sync_token

      data.each do |attr_key, val|
        if (self.class.references || {}).key?(attr_key)
          raise "#{val} must be of type #{self.class.references[attr_key]}" if self.class.references[attr_key] != val.class
        end

        raise "#{attr_key} is not an attribute of #{self.class}" unless self.class.attributes.include?(attr_key)
      end

      self.class.attributes.each do |attribute|
        instance_variable_set("@#{attribute}", data.dig(attribute))
      end
    end

    def attributes
      self.class.attributes
    end

    def references
      self.class.references
    end

    def serialize_attributes
      Hash[self.class.attributes.map { |a| [a, send(a)] }]
    end

    # def serializable_type
    #   self.class.resource_type
    # end

    def self.attribute(name)
      attributes << name.to_sym
      class_eval { attr_accessor name }
    end

    def self.attributes
      @attributes ||= []
    end

    def self.klass_from_resource_type(obj)
      LedgerSync.const_get(LedgerSync::Util::StringHelpers.camelcase(obj))
    end

    def self.reference(name, type)
      attribute(name)
      references[name.to_sym] = type
    end

    def self.references
      @references ||= {}
    end

    def self.reference_klass(name)
      references[name.to_sym]
    end

    def self.reference_resource_type(name)
      reference_klass(name).resource_type
    end

    def self.resource_type
      @resource_type ||= LedgerSync::Util::StringHelpers.underscore(name.split('::').last).to_sym
    end

    def ==(other)
      other.fingerprint == fingerprint
    end
  end
end
