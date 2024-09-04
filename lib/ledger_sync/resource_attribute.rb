# frozen_string_literal: true

require 'ledger_sync/type/value'

Gem.find_files('ledger_sync/type/**/*.rb').each do |path|
  require path
end

Gem.find_files('ledger_sync/resource_attribute/**/*.rb').each do |path|
  require path
end

module LedgerSync
  class ResourceAttribute
    include Fingerprintable::Mixin
    include SimplySerializable::Mixin
    include Util::Mixins::DupableMixin

    attr_reader :name,
                :reference,
                :resource_class,
                :type,
                :value,
                :default

    def initialize(args = {})
      @name           = args.fetch(:name).to_sym
      @resource_class = args.fetch(:resource_class)
      @type           = args.fetch(:type)
      @value          = args.fetch(:value, nil)
      @default        = args.fetch(:default, nil) # Default if nil value

      @type = type.new if type.respond_to?(:new) && !type.is_a?(Type::Value)

      raise "Invalid Type: #{type}" unless type.is_a?(ActiveModel::Type::Value)
    end

    def assert_valid(args = {})
      # pd args
      # pd default
      value = args.fetch(:value, default)

      type.assert_valid(value: value)
    rescue Error::TypeError::ValueClassError
      raise ResourceAttributeError::TypeError.new(
        attribute: self,
        resource_class: resource_class,
        value: value
      )
    end

    def cast(value)
      cast_val(value)
    end

    # This is for ActiveModel::Dirty, since we define @attributes
    # def forgetting_assignment; end

    def reference?
      is_a?(Reference)
    end

    def references_many?
      is_a?(Reference::Many)
    end

    def valid_with?(value:)
      type.valid?(value: value)
    end

    def value=(val)
      @value = cast_val(val)
    end

    def will_change?(val)
      assert_valid(value: val)
      value != cast_val(val)
    end

    def cast_val(val)
      type.cast(value: val, default: default)
    end
  end
end
