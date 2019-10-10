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

    dirty_attribute :external_id, :ledger_id, :sync_token

    def initialize(external_id: nil, ledger_id: nil, sync_token: nil, **data)
      @external_id = external_id.try(:to_sym)
      @ledger_id = ledger_id
      @sync_token = sync_token

      super(data)
    end

    def klass_from_resource_type(obj)
      LedgerSync.const_get(LedgerSync::Util::StringHelpers.camelcase(obj))
    end

    def self.resource_type
      @resource_type ||= LedgerSync::Util::StringHelpers.underscore(name.split('::').last).to_sym
    end

    def ==(other)
      other.fingerprint == fingerprint
    end
  end
end
